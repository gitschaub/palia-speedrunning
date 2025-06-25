# LiveSplit

## Setup 

Open LiveSplit, right-click -> Open Splits -> From File. Select 
"Palia - Tower Any% No Major Glitches.lss"

Splits are described at https://www.speedrun.com/Palia/resources/zcllg

## Autosplitter

Check https://github.com/gitschaub/palia-speedrunning/releases and download the
PaliaAutoSplitter.asl for the current version of Palia. If you use the wrong
version of the script autosplitting *will not work*. 

To enable the autosplitter, right-click -> Edit Layout. Click `+` to add a
component and add a Component -> Scriptable Auto Splitter

Double-click Scriptable Auto Splitter in the layout editor. Under the
Scriptable Auto Splitter tab, add the path to "PaliaAutoSplitter.asl"

Miscellaneous data for Autosplitter setup can be found on this
[Google Sheet](https://docs.google.com/spreadsheets/d/1KnYFdF4trGha7mfaerRIvI032Hwl7jRkSUcTM8AYoEU#gid=972918659)

### How it works

The AutoSplitter script reads your character's position from process memory.
Each split is represented as a hitbox around the rough area described in the
splits file. Each checkpoint must be reached sequentially in order for the
split to trigger.

### Limitations

Any client updates are going to break this.

Should work on Windows (Windows launcher and Steam), won't work on other platforms.

I really ought to maintain this on github.

If you encounter bugs, feel free to reach out on the Discord server and I can try to help.

### Steps for updating the Autosplitter

<YouTube walkthrough coming soon>

1. Find the address for character's X coordinate. 
    a. The starting X value is 19430.  Do a "first scan" for exact Double value of 19430. 
	b. Walk forward and "next scan" for increased value, walk backward and "next scan" 
	    for decreased value. Repeat until there are ~200 addresses.
    c. Add all addresses to your address list, and bulk edit values to find which one is
	    your character's X position.
2. Generate a pointer map and save it. Note down the address.
3. Restart the game and repeat steps 1 and 2
4. Do a pointer scan using the second pointer map, comparing to the first
   pointer map (using the address saved in the first step).
   Check "Pointers must end with specific offsets" and enter 260 in the first field
5. Sort the Offset 6 column to find chains with fewer pointers. Double-click
    a bunch of pointers to add them to the address list.
6. Restart the game, and leave and re-enter the tower multiple times 
   to see which pointers are stable. Any values that change while you are not
   moving or show "??" can be deleted.
7. Update ASL with the new pointer path.