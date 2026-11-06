# Old Eyes

An add-on for World of Warcraft that will modify the WoW interface to increase the font size of quest, gossip and optionally, merchant frames.

# Repository

https://github.com/PHANTOM-40417/Old-Eyes

# End of Service
As I haven't been playing World of Warcraft since 2018, this add-on is being retired. Feel free to fork the repo and make any additional changes yourselves.

# World of Warcraft: Forever Commands
The following commands can be used as a starting point for World of Warcraft Forever frame scaling. This is as far as I got and I will not be continuing any further.

https://gist.github.com/PHANTOM-40417

# Version History

### 2026.11.3

#### Updates

- Updated add-on compatibility for World of Warcraft interface version 120105.
- Replaced the deprecated `InterfaceOptions_AddCategory()` API with Blizzard's modern Settings API.
- Updated the add-on options panel to use the current settings registration system.
- Reworked settings checkboxes to restore their visual appearance and functionality.
- Preserved the three existing configuration options:
  - Scale Merchant Frame
  - Scale Player Frames
  - Scale Objective Tracker

#### Improvements

- Improved initialization and handling of SavedVariables.
- Preserved default enabled settings for all three scaling options.
- Added support for scaling frames when they become available after login.
- Added support for frames loaded on demand.
- Added deferred scaling for protected frames when combat restrictions prevent immediate changes.
- Added frame scaling hooks to reapply scaling when supported frames are displayed.
- Removed unnecessary logout-based SavedVariables handling.
- Preserved the original 1.25 scaling factor.

#### Bug Fixes

- Fixed an initialization error caused by the removal of the legacy Interface Options API.
- Fixed the add-on failing to initialize its event handling.
- Fixed missing checkboxes in the add-on options panel.
- Restored the login notification in the chat window.
- Improved handling of unavailable Blizzard UI frames.

#### Preserved Features

- Quest frame scaling.
- Gossip frame scaling.
- Book and readable text scaling.
- Group Finder scaling.
- Optional merchant frame scaling.
- Optional player, target, and focus frame scaling.
- Optional objective tracker scaling.

### 2021.0.0.0

July 18, 2021

- Added support to increase the frame size for books.
- Added support to increase the size of the LFG frame.
- Added support to optionally increase the size of the player frames.
- Added support to optionally increase the size of the objective tracker.

# Options

- Features an in-game option which allows **merchant scaling** to be enabled or disabled.
- Features an in-game option which allows player **frame scaling** to be enabled or disabled.
- Features an in-game option which allows objective **tracker scaling** to be enabled or disabled.

# Installation

Common add-on location: C:\Program Files (x86)\World of Warcraft\_retail_\Interface\Addons

1. Copy the entire add-on folder to your add-on directory.
2. Open the Old Eyes folder and delete the .git folder inside of it. You may need to enable hidden files and folders to see the .git folder.
3. Run the game.
   
# Compatibility

This add-on has not been tested with other add-ons. If you encounter issues, please try disabling all other add-ons to see if that resolves the issue. I do not provide support for other add-ons.

# Notes

To check the current WoW interface version use the following command in the chat window:

```
/run print((select(4, GetBuildInfo())));
```
