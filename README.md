# Speeder

# Setup

## Linux
1. Download the Playdate SDK from [https://download.panic.com/playdate_sdk/Linux/PlaydateSDK-latest.tar.gz](https://download.panic.com/playdate_sdk/Linux/PlaydateSDK-latest.tar.gz)
2. Untar the archive at prefered location, e.g. `$HOME/`
3. Add following line to you shel's startup file (`.bashrc`, `.zshrc`, etc.)
> export PLAYDATE_SDK_PATH=<path to SDK folder&gt;
4. (optional) Add `<path to SDK folder>/bin/` to your `$PATH` variable so you can use `pdc` and `pdutil` commands

# Compiling & running a game
To compile and "install" game directly in the Playdate Simulator run the following command:
> pdc <path to GameDirectory&gt;/ <path to SDK folder&gt;/Disk/Games/fathersave.pdx

This should create a compiled game folder inside a Simulator's game library. Now the only thing left to do is to run the Simulator (available at `<path to SDK folder/bin/PlaydateSimulator`) and playtest the game!

# Reference list
1. Official SDK documentation: [https://sdk.play.date/1.13.0/](https://sdk.play.date/1.13.0/)
2. Free assets library: [https://itch.io/game-assets/tag-playdate](https://itch.io/game-assets/tag-playdate)

# Attributions
1. [Desert background image](https://www.freepik.com/free-vector/desert-forest-landscape-daytime-scene_16254303.htm#query=desert%20background&position=20&from_view=keyword&track=ais)
2. [Cat sprite](https://elthen.itch.io/2d-pixel-art-cat-sprites)
3. [Rock sprite](https://verzatiledev.itch.io/rocks)
4. [Cactus sprite](https://www.freepik.com/free-vector/silhouettes-cactus_804755.htm#query=cactus&position=0&from_view=search&track=sph)