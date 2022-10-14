package;

import openfl.system.System;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var fpsDisplay:FPS_Mem;

	public static var novid:Bool = false;
	public static var flippymode:Bool = false;

	public function new()
	{
		super();

		SUtil.uncaughtErrorHandler();

		#if sys
		novid = Sys.args().contains("-novid");
		flippymode = Sys.args().contains("-flippymode");
		#end

		SUtil.check();

		addChild(new FlxGame(0, 0, Startup, 1, 60, 60, true));

		fpsDisplay = new FPS_Mem(10, 3, 0xFFFFFF);
		fpsDisplay.visible = true;
		addChild(fpsDisplay);
		switch (FlxG.save.data.fpsDisplayValue)
		{
			case 0:
				Main.fpsDisplay.visible = true;
				Main.fpsDisplay.showMem = true;
			case 1:
				Main.fpsDisplay.visible = true;
				Main.fpsDisplay.showMem = false;
			case 2:
				Main.fpsDisplay.visible = false;
		}

		FlxG.signals.postStateSwitch.add(function()
		{
			System.gc();
		});

		// On web builds, video tends to lag quite a bit, so this just helps it run a bit faster.
		#if web
		VideoHandler.MAX_FPS = 30;
		#end

		trace("-=Args=-");
		trace("novid: " + novid);
		trace("flippymode: " + flippymode);
	}
}
