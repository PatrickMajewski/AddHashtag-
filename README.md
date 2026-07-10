<p align="left">
  <img src="images/hashtag.png" width="180">
</p>

<h1 align="left">AddHashtag</h1>

*A simple Windows utility for organizing files with searchable hashtags.*

AddHashtag extends the Windows **Send to** menu with a convenient way to add, edit and remove hashtags from filenames.

Instead of relying on hidden metadata or proprietary tagging systems, hashtags are stored directly in the filename. This makes them portable, transparent and instantly searchable across Windows.

---

## Why?

Windows has never offered a simple, universal file tagging system.

While macOS provides Finder Tags, they are tied to Apple's ecosystem and rely on metadata. AddHashtag takes a different approach by embedding hashtags directly into filenames, making them visible everywhere without requiring any special software or databases.

The real strength of this approach becomes apparent when used together with **Everything** by Voidtools.

Since Everything indexes filenames almost instantly, your hashtags become searchable across your entire computer within seconds.

---

## Features

* Integrates directly into the Windows **Send to** menu
* Add hashtags to one or hundreds of files at once
* Automatically detects existing hashtags
* Edit or remove existing hashtags before saving
* Preserves the original filename
* No hidden metadata
* No database
* Works with any application that displays filenames
* Optimized for use with **Everything**

---

## How it works

Example:

Before:

```text
Vacation.jpg
Invoice.pdf
Project.zip
```

After adding **#holiday #2026**:

```text
Vacation #holiday #2026.jpg
Invoice #holiday #2026.pdf
Project #holiday #2026.zip
```

Searching for

```text
#holiday
```

in Everything immediately finds every tagged file.

---

## Installation

Download the latest release package:

AddHashtag-v1.0.1.zip

Extract the ZIP file and run:

INSTALL.bat

The installer will automatically configure the required folders and Windows Explorer integration.

UNINSTALLer is also included.

---

## Usage

### Add hashtags

1. Select one or more files.
2. Right-click.
3. Choose **Send to → Add Tag**.
4. Enter one or more hashtags.

---

### Edit existing hashtags

If the selected files already contain hashtags, AddHashtag detects them automatically and displays them in a list.

Click any existing hashtags you want to keep. Unselected hashtags are removed when the filename is updated.

---

## Recommended Software

Although AddHashtag works with Windows Search, it is designed to be used together with **Everything**.

### Everything

Everything by Voidtools indexes filenames almost instantly, making hashtag searches effectively instantaneous.

https://www.voidtools.com/

### Everything Toolbar

Everything Toolbar integrates Everything directly into the Windows taskbar, providing immediate access to filename searches from anywhere.

https://github.com/stnkl/EverythingToolbar

---

## Why filenames instead of metadata?

Using filenames instead of metadata has several advantages.

* Works on every NTFS drive
* Survives copying and moving files
* Compatible with cloud storage
* Compatible with ZIP archives
* Compatible with backups
* No proprietary file attributes
* No additional indexing
* Human-readable
* Searchable by virtually every filename search tool

---

## Planned Features

* Automatic installer [DONE]
* Optional keyboard shortcuts

Suggestions and feature requests are welcome.

---

## License

AddHashtag is distributed under a custom license.

Please review the included LICENSE file before using, modifying, or redistributing this software.

Personal use is permitted. Any redistribution, modification, commercial use, or integration into other software requires prior written permission from the author.
