<img src='https://cdn.discordapp.com/attachments/614186484248870943/1033139013579706498/unknown.png' width='750'>

# Previews
<img src='https://i.gyazo.com/af21b872ab0d5aaa476cf069a4b868c5.png'><img src='https://i.gyazo.com/669c5e3889076eebc8eda518325a949e.png'>

# Support:

For support join my discord here: https://discord.gg/scully

# Installation Instructions:

* add `ensure dpemotes` to your `server.cfg`

# Requirements

- [ox_lib](https://github.com/overextended/ox_lib)

# Features

- Custom animations

- Animal Emotes

- Synchronized animations (WIP)

- Synchronized particle effects

- Ability to hide certain menus, NSFW emotes and social movement emotes

- Easy To understand configuration file

- Exports to integrate within other resources

- Walk styles that save

- Prop variation support

# Exports

**How to use exports:** `exports['dpemotes']:ExportName(Parameter(s))`

| Export Name | Parameter(s) | Supported On | Description |
| ------------- | ------------- | ------------- | ------------- |
| OpenMenu | None | Client | Open the menu |
| CloseMenu | None | Client | Close the menu |
| GetCurrentWalk | None | Client | Returns your current walk style |
| SetWalk | Name | Client | Sets your walk style |
| ResetWalk | None | Client | Resets your walk style to default |
| IsInAnimation | None | Client | Check if you're playing an animation |
| Play | Type, Table, Prop Variant | Client | Play an animation |
| PlayByCommand | Name, Prop Variant | Client | Play an animation using the command name |
| CancelAnimation | None | Client | Stop playing an animation |

# Menu Keybind

**Important Note:**

By default the configured keybind in the *initial* config.lua will be the default key, however once the keybind is set for a player, it'll stay and editing the keybind in the config will change it for new players only. Previous players can set their own keybind to open the menu within `Esc > settings > keybinds > fivem`.

# Keybinds

You can use the keybind command that comes with FiveM by entering the following into F8:

`bind keyboard 'Yourbutton' 'e youremote'`. To remove the keybind, type `'unbind keyboard 'Yourbutton'`.

# NSFW & Social Movement Animations

NSFW and social movement animations can be toggled in the menu by setting `EnableNSFWEmotes` and `EnableSocialMovementEmotes` in the config.lua file. The emotes that are toggled are the ones flagged in the animation list with `NSFW` and `SocialMovement`.

# Disclaimer & Credits

All custom animations were added with permission from the creators, the original creator Dulpear_Dev stated that he himself is also happy with this project. Credit to the following people for their animations / props and Dulpear for providing the original project:

- [Dullpear_dev](https://forum.cfx.re/u/dullpear_dev/summary)

- [SMGMissy](https://forum.cfx.re/u/smgmissy/)

- [Ultrahacx](https://forum.cfx.re/u/ultrahacx/summary)

- [Smokey](https://www.gta5-mods.com/users/struggleville)

- [BzZzi](https://forum.cfx.re/u/bzzzi/summary)

- [Natty3d](https://forum.cfx.re/u/natty3d/summary)

- [Sam](https://www.lcpdfr.com/profile/12-sam/)

- [Struggleville](https://www.gta5-mods.com/users/struggleville)

- [Eaglee](https://www.gta5-mods.com/users/Eaglee)

- [Steph21](https://www.gta5-mods.com/users/Steph21)
