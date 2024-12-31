# doom-captcha

A DOOM®-based CAPTCHA for the web¹

## How it works

The project works by leveraging Emscripten to compile a minimal port of Doom to WebAssembly and
enable intercommunication between the C-based game runloop and the JavaScript-based CAPTCHA UI.

Some extensions were made to the game to introduce relevant events needed for its usage
in the context of a CAPTCHA.

- Started out with a minimal, SDL-based port of Doom that can be efficiently compiled to WebAssembly by [Lorti](https://github.com/lorti).
- Tweaked the build to make it compatible with the shareware version of wad (`doom1.wad`) for legal use
- Introduced new unofficial process flags:
  - `-nomenu` to skip the main menu and jump straight into the game (`m_menu.c`)
  - `-autoreborn` to automatically rebirth the player after a 2s delay (`m_player.c`)
- Introduced callbacks into JS land to be used by the CAPTCHA UI:
  - `onPlayerBorn` when the player is born or reborn
  - `onPlayerKilled` when the player is killed
  - `onEnemyKilled` when the main player kills an enemy
- Tweaked the default process flags to make the game more challenging and skip all the menus:
  - `-skill 5` sets the difficulty to "Nightmare!"
  - `-fast` makes it even harder
  - `-warp e1m1` jumpstarts the game to where the action is
  - `-nomenu` doesn't let the player trigger the main menu

## Developing

- Install [Emscripten](https://emscripten.org/docs/getting_started/downloads.html)
  - On macOS, `brew install emscripten` does the trick
- Place `doom1.wad` in the `sdldoom-1.10` directory (Shareware version)
- Run `build.sh`
  - Get the DOOM® shareware WAD URL and save it to `$DOOM_WAD_URL`
  - During development, I recommend running `watchexec -- ./build.sh` to make the process automatic (install [watchexec](https://github.com/watchexec/watchexec) with `brew install watchexec`)
- Run `vercel dev`

## Credits

- [SDLDoom 1.10](https://www.libsdl.org/projects/doom/)
- [sdldoom.wasm](https://github.com/Lorti/sdldoom.wasm) by [Lorti](https://github.com/Lorti)
- [Emscripten](https://emscripten.org/)
- [Doom Shareware WAD](https://doomwiki.org/wiki/DOOM1.WAD)
- DOOM® is a registered trademark of id Software LLC, a ZeniMax Media company
- Stylized as a reference to Google's reCAPTCHA
- [Prior art](https://vivirenremoto.github.io/doomcaptcha/) in spirit by [vivirenremoto](https://github.com/vivirenremoto)

_¹ for educational and entertainment purposes only_
