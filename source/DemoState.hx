package;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author bbpanzu
 */
class DemoState extends FlxState
{

	var _goodEnding:Bool = false;
	
	public function new(goodEnding:Bool = true) 
	{
		super();
		_goodEnding = goodEnding;
		
	}
	
	override public function create():Void 
	{
		trace(PlayState.storyWeek);
		super.create();	
		var end:FlxSprite = new FlxSprite(0, 0);
		var blackTrans:FlxSprite = new FlxSprite(0, 56);
		if (PlayState.storyWeek == 0)
	    {
			FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
			blackTrans.makeGraphic(FlxG.width, 400, FlxColor.BLACK);
			add(blackTrans);
			endIt();
        }
		else
			FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
			end.loadGraphic(Paths.image("demoEnd"));
			add(end);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (FlxG.keys.pressed.ENTER){
			endIt();
		}
		
	}
	
	
	public function endIt(e:FlxTimer=null){
		trace("ENDING");
		FlxG.switchState(new StoryMenuState());
	}
	
}