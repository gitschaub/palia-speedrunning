/*
 * The state section is required for every script. It defines which process to
 * connect to (without the .exe).
 */

// TODO: Detect level (tower) to prevent autosplitter from running in `update`
state("PaliaClient-Win64-Shipping")
{
        double x : 0x08EBC058, 0x0, 0x20, 0x228, 0x0, 0x260;
        double y : 0x08EBC058, 0x0, 0x20, 0x228, 0x0, 0x268;
        double z : 0x08EBC058, 0x0, 0x20, 0x228, 0x0, 0x270;
}

state("PaliaClientSteam-Win64-Shipping")
{
        double x : 0x08F532D8, 0x0, 0x90, 0x228, 0x0, 0x260;
        double y : 0x08F532D8, 0x0, 0x90, 0x228, 0x0, 0x268;
        double z : 0x08F532D8, 0x0, 0x90, 0x228, 0x0, 0x270;		
}

startup
{
	// Formatted as [ x_min, x_max, y_min, y_max, z_min, z_max ]
	// X is West->East, Y is North->South, Z is Down->Up.
	double[] furnitureRoad = new double[6] { 15300, 16500, -2625, -1890, 4050, 4550 };
	double[] boulders = new double[6] { 26200, 26700, -10500, -9000, 11900, 12200 };
	double[] greenPlats = new double[6] { 12700, 13400, -14250, -13600, 11900, 12300 };
	double[] bluePlats = new double[6] { 15900, 16200, -3400, -3100, 16900, 18250 };
	double [] ikeaRoad = new double[6] { 13500, 13745, -21500, -21200, 24650, 24850 };
	double [] ikea = new double[6] { 14750, 15250, -21300, -21000, 29375, 29775 };
	double [] finalFloor = new double[6] { 16500, 16700, 1250, 2250, 37200, 37400 };
	double [] finalPlats = new double[6] { 18600, 19750, -8800, -8650, 44100, 44300 };
	vars.checkpoints = new double[][] {  
		furnitureRoad,
		boulders,
		greenPlats,
		bluePlats,
		ikeaRoad,
		ikea,
		finalFloor,
		finalPlats,
	};
	
	// Entering this area will start the timer. It's front border is at the
	// in-game timer trigger.
	vars.StartZone = new double[] { 22430, 22580, -10075, -8480, 1950, 2550 };
	
	// Entering this area will trigger a timer reset. This is most of the
	// starting area inside the tower, extending close to the starting line.
	vars.ResetZone = new double[] { 17700, 22000, -10500, -7750, 1950, 2550 };

	// Stolen from Alan Wake example for debugging.
	Action<string> DebugOutput = (text) => {
		print("[Palia Autosplitter] "+text);
	};
	vars.DebugOutput = DebugOutput;
	
	Func<double[], double, double, double, bool> PointInBox = (bounds, x, y, z) => {
		return x > bounds[0] && x < bounds[1] &&
			   y > bounds[2] && y < bounds[3] &&
			   z > bounds[4] && z < bounds[5];
	};
	vars.PointInBox = PointInBox;

	vars.prevUpdateTime = -1;
	vars.lastCheckpoint = -1;
}

init
{
  // TODO: Detect game version? Detect that the player is in the tower?
}

/*
 * The "update" Action is called as long as the script is connected to a process.
 * It is a general update Action which can be used to do stuff that should always
 * run independant of the current Timer state.
 */
update
{
	// Debug output
	var timeSinceLastUpdate = Environment.TickCount - vars.prevUpdateTime;
	if (timeSinceLastUpdate > 5000 || vars.prevUpdateTime == -1)
	{
		vars.prevUpdateTime = Environment.TickCount;
		vars.DebugOutput("Player Coordinates: " + current.x + ", " + current.y + ", " + current.z);
		if (vars.lastCheckpoint != -1) {
			vars.DebugOutput("Last checkpoint: " + vars.lastCheckpoint);
		}
	}
}

start
{
	if (vars.PointInBox(vars.StartZone, current.x, current.y, current.z)) {
		vars.DebugOutput("Timer started");
		vars.lastCheckpoint = -1;
		return true;
	}
}

reset
{
	if (vars.PointInBox(vars.ResetZone, current.x, current.y, current.z)) {
		vars.DebugOutput("Timer reset");
		vars.lastCheckpoint = -1;
		return true;
	}
	return false;
}

split
{
	// Scan across all potential checkpoints
	for (int i = 0; i < vars.checkpoints.Length; i++) {
		if (vars.PointInBox(vars.checkpoints[i], current.x, current.y, current.z) &&
			i == vars.lastCheckpoint+1) {
			vars.DebugOutput("Player reached checkpoint_" + i);
			vars.lastCheckpoint++;
			return true;
		}
	}
}