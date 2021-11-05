package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;

using StringTools;

class MainMenuState extends MusicBeatState
{
	
	var curSelected:Int = 0;
	var shower:FlxSprite;
	var show:String = "";
	public static var reRoll:Bool = true; 
	public static var lastRoll:String = "menu1";

	var menuItems:FlxTypedGroup<FlxSprite>;
	
	//var configText:FlxText;
	//var configSelected:Int = 0;
	
	var optionShit:Array<String> = ['story mode', 'freeplay', 'donate', "options"];

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	var versionText:FlxText;
	var keyWarning:FlxText;

	override function create()
	{

		openfl.Lib.current.stage.frameRate = 144;

		if (!FlxG.sound.music.playing)
		{	
			FlxG.sound.playMusic("assets/music/klaskiiLoop.ogg", 0.75);
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuBG.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.18));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
	
		magenta = new FlxSprite(-80).loadGraphic('assets/images/menuBGMagenta.png');
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.18;
		magenta.setGraphicSize(Std.int(magenta.width * 1.18));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		add(magenta);
		// magenta.scrollFactor.set();

		if (reRoll)
			{
				var random = FlxG.random.float(0,9000);
				show = 'menu1';
				if (random >= 1000 && random <= 3999)
					show = 'menu2';
				if (random >= 4000 && random <= 6999)
					show = 'menu3';
				lastRoll = show;
				trace('random ' + random + ' im showin ' + show);
			}
			else
				show = lastRoll;

			shower = new FlxSprite(600,200);

			Conductor.changeBPM(165);
               //@author KadeDev
              /* https://cdn.discordapp.com/attachments/618912618165305413/886765698737651793/unknown.png */

			switch(show)
			{
				case 'menu1':
					shower.frames = Paths.getSparrowAtlas("menuTest/ligma");
					shower.animation.addByPrefix('idle','hypno-portrait');
					shower.scrollFactor.set();
					shower.x = 650;
					shower.setGraphicSize(Std.int(shower.width * 1));
	
				case 'menu2':
					shower.frames = Paths.getSparrowAtlas("menuTest/troleoBF");
					shower.animation.addByPrefix('idle','boyfriend-portrait');
					shower.scrollFactor.set();
					shower.x = 10;
					shower.y = -150;
					shower.setGraphicSize(Std.int(shower.width * 0.5));

				case 'menu3':
					shower.frames = Paths.getSparrowAtlas("menuTest/cubo");
					shower.animation.addByPrefix('idle','boyfriend-portrait');
					shower.scrollFactor.set();
					shower.x = 10;
					shower.y = -150;
					shower.setGraphicSize(Std.int(shower.width * 0.5));

            }
			shower.antialiasing = true;

			shower.animation.play('idle');
	
			add(shower);


		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = FlxAtlasFrames.fromSparrow('assets/images/FNF_main_menu_assets.png', 'assets/images/FNF_main_menu_assets.xml');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(220, 60 + (i * 160));
			menuItem.frames = tex;
			
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.x-= 200;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}

		FlxG.camera.follow(camFollow, null, 0.004);

		versionText = new FlxText(5, FlxG.height - 21, 0, Assets.getText('assets/data/version.txt'), 16);
		versionText.scrollFactor.set();
		versionText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionText);

		keyWarning = new FlxText(5, FlxG.height - 21 + 16, 0, "If your controls aren't working, try pressing P to reset them.", 16);
		keyWarning.scrollFactor.set();
		keyWarning.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		keyWarning.alpha = 0;
		add(keyWarning);

		FlxTween.tween(versionText, {y: versionText.y - 16}, 0.75, {ease: FlxEase.quintOut, startDelay: 10});
		FlxTween.tween(keyWarning, {alpha: 1, y: keyWarning.y - 16}, 0.75, {ease: FlxEase.quintOut, startDelay: 10});

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();
		
		//Offset Stuff
		Config.reload();

		super.create();
	}

	var selectedSomethin:Bool = false;

	var mostrar:FlxTween;
	function cancelTweens()
		{
			mostrar.cancel();
		}

	override function update(elapsed:Float)
	{
	
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				changeItem(1);
			}

			if (FlxG.keys.justPressed.P)
			{
				KeyBinds.resetBinds();
				FlxG.switchState(new MainMenuState());
			}
			
			if (FlxG.keys.justPressed.BACKSPACE)
				{
					FlxG.switchState(new TitleState());
				}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
			
				//Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0);
				{
					selectedSomethin = true;
					FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);
					mostrar = FlxTween.tween(shower,{alpha: 0, y: shower.y + 56}, 1 ,{ease: FlxEase.expoOut, startDelay: 0.5});
					mostrar = FlxTween.tween(versionText,{alpha: 0}, 1 ,{ease: FlxEase.expoOut, startDelay: 0.5});
					mostrar = FlxTween.tween(keyWarning,{alpha: 0}, 1 ,{ease: FlxEase.expoOut, startDelay: 0.5});
					
					var daChoice:String = optionShit[curSelected];
					
					switch (daChoice){
						case 'freeplay':
							FlxG.sound.music.stop();
						case 'options':
							FlxG.sound.music.stop();
					}

					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								//var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story mode':
										FlxG.switchState(new StoryMenuState());
										trace("Story Menu Selected");
									case 'freeplay':
										FreeplayState.startingSelection = 0;
										FlxG.switchState(new FreeplayState());
										trace("Freeplay Menu Selected");
									case 'options':
										FlxG.switchState(new ConfigMenu());
										trace("options time");
									case 'donate':
										FlxG.switchState(new Creditos());
										trace("credits");
								}
							});
						}
					});
				}
			}
		}

		super.update(elapsed);

	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;
		//configSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
 		if (curSelected < 0)
			curSelected = menuItems.length - 1;
			
		/*if (configSelected > 3)
			configSelected = 0;
		if (configSelected < 0)
			configSelected = 3;*/

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
