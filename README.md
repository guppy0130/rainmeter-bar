# Rainmeter Bar

Polybar but make it Windows(TM)

Written by Guppy0130. Licensed under GNU GPLv3.

## [Changelog](CHANGELOG.md)

## Screenshots

Run [fix-screenshots.ps1](fix-screenshots.ps1) to fix screenshots. Assumes 1920px wide monitor.

### Ethernet

![Ethernet-no-music](screenshots/ethernet-no-music.png)
![Ethernet-playing](screenshots/ethernet-playing.png)
![Ethernet-paused](screenshots/ethernet-paused.png)
![Ethernet-muted](screenshots/ethernet-muted.png)

### Wireless

![Wireless-no-music](screenshots/wireless-no-music.png)

## Installation

### Prerequisites

* Rainmeter v4.4r3350.
* [Spicetify](https://github.com/khanhas/spicetify-cli) (tested with v0.9.7).
* Font [Envy Code R](https://damieng.com/blog/2008/05/26/envy-code-r-preview-7-coding-font-released), patched with NerdFonts.
  * <https://hub.docker.com/r/nerdfonts/patcher>
  * `--complete --mono` extra args should be passed (`Bar.ini` wants mono)

### Skin Installation

Check releases, or use git:

```powershell
cd $env:userprofile/Documents/Rainmeter/skins
# or where your Rainmeter installation is
git clone https://github.com/guppy0130/rainmeter-bar.git
# or git clone https://gitlab.com/guppy0130/rainmeter-bar.git
```

Open Rainmeter, open folder `rainmeter-bar`, and double-click `Bar.ini` to load it.

## Modifying

Modify `logic.lua` (actual logic/string building) or `Bar.ini` (fonts, measures, plugins, etc).
