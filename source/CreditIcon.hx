package;

import flixel.FlxSprite;

class CreditIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */

	public function new(xPos:Float = 0, yPos:Float = 0, icon:String = 'Kingfox')
	{
		super(xPos, yPos);
		loadGraphic(Paths.image('credits/icon' + icon));
	}
}
