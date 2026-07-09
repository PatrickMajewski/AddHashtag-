$FileList = @($args)
if ($FileList.Count -eq 0) { exit }

Add-Type -AssemblyName PresentationFramework

# 1. Den "Tag-Pool" aufbauen
$pool = @()
foreach ($path in $FileList) {
    if (Test-Path -LiteralPath $path) {
        $baseName = (Get-Item -LiteralPath $path).BaseName
        $matches = [regex]::Matches($baseName, '(?:^|\s+)#([\w-]+)')
        foreach ($match in $matches) {
            $pool += $match.Groups[1].Value
        }
    }
}
$uniqueTags = $pool | Select-Object -Unique

# 2. Die Benutzeroberfläche (WPF XAML)
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="add tag ($($FileList.Count) Dateien)" Height="260" Width="420"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        Background="#1e1e1e" Foreground="#d4d4d4" FontFamily="Segoe UI">
    <Grid Margin="15">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Orientation="Horizontal" Margin="0,0,0,15">
            <TextBlock Text="#" FontSize="20" VerticalAlignment="Center" Margin="0,0,8,0" Foreground="#007acc"/>
            <TextBox Name="TagInput" Width="340" Height="30" FontSize="14" 
                     Background="#252526" Foreground="White" BorderBrush="#3f3f46"
                     VerticalContentAlignment="Center" Padding="5,0"/>
        </StackPanel>

        <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
            <WrapPanel Name="TagPanel" Orientation="Horizontal"/>
        </ScrollViewer>

        <StackPanel Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,15,0,0">
            <Button Name="BtnCancel" Content="Abbrechen" Width="80" Height="28" Margin="0,0,10,0" 
                    Background="#333333" Foreground="White" BorderThickness="0"/>
            <Button Name="BtnOk" Content="OK" Width="80" Height="28" 
                    Background="#007acc" Foreground="White" BorderThickness="0" IsDefault="True"/>
        </StackPanel>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [System.Windows.Markup.XamlReader]::Load($reader)

$tagInput = $window.FindName("TagInput")
$tagPanel = $window.FindName("TagPanel")
$btnOk = $window.FindName("BtnOk")
$btnCancel = $window.FindName("BtnCancel")

# 3. Dynamische "Chip"-Buttons generieren
foreach ($tag in $uniqueTags) {
    $btn = New-Object System.Windows.Controls.Button
    $btn.Content = $tag
    $btn.Margin = "0,0,8,8"
    $btn.Padding = "12,6"
    $btn.Background = "#333333"
    $btn.Foreground = "#d4d4d4"
    $btn.BorderThickness = "0"
    
    $btn.Add_Click({
        param($sender, $e)
        if ([string]::IsNullOrWhiteSpace($tagInput.Text)) {
            $tagInput.Text = $sender.Content
        } else {
            $tagInput.Text += " " + $sender.Content
        }
        $tagInput.CaretIndex = $tagInput.Text.Length
        $tagInput.Focus()
    })
    $tagPanel.Children.Add($btn)
}

$btnOk.Add_Click({ $window.DialogResult = $true })
$btnCancel.Add_Click({ $window.DialogResult = $false })

$tagInput.Focus()
$result = $window.ShowDialog()

# 5. Ausführung 
if ($result -eq $true) {
    $newTagText = $tagInput.Text.Trim()
    $errorList = @()
    
    foreach ($path in $FileList) {
        if (Test-Path -LiteralPath $path) {
            $file = Get-Item -LiteralPath $path
            $ext = $file.Extension
            
            # DER FIX: \s*$ erlaubt nun Leerzeichen am Ende, damit das F2-Leerzeichen nicht stört
            $baseName = ($file.BaseName -replace '((?:^|\s+)#[\w-]+)+\s*$', '').Trim()
            
            if ([string]::IsNullOrWhiteSpace($newTagText)) {
                # Wenn Feld leer: Komplett ent-taggen (kein extra Leerzeichen vor der Endung)
                $newName = "$baseName$ext"
            } else {
                # Wenn Text vorhanden: F2-Leerzeichen vor der Endung einbauen
                $parts = $newTagText -split '\s+'
                $formattedTags = ($parts | ForEach-Object { "#$($_.TrimStart('#'))" }) -join " "
                $newName = "$baseName $formattedTags $ext"
            }
            
            if ($file.Name -ne $newName) {
                try {
                    Rename-Item -LiteralPath $file.FullName -NewName $newName -ErrorAction Stop
                } catch {
                    $errorList += "Fehler bei '$($file.Name)': $($_.Exception.Message)"
                }
            }
        }
    }
    
    if ($errorList.Count -gt 0) {
        [System.Windows.MessageBox]::Show(($errorList -join "`n"), "Umbenennung fehlgeschlagen", 0, 16)
    }
}
