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