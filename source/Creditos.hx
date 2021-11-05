package;

import openfl.system.System;
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

class Creditos extends MusicBeatState
{


	var configText:FlxText;
	var descText:FlxText;
	var tabDisplay:FlxText;
	var configSelected:Int = 0;
	
	var offsetValue:Float;
	var accuracyType:String;
	var accuracyTypeInt:Int;
	var accuracyTypes:Array<String> = ["none", "simple", "complex"];
	var healthValue:Int;
	var healthDrainValue:Int;
	var iconValue:Bool;
	var downValue:Bool;
	var glowValue:Bool;
	var randomTapValue:Int;
	var randomTapTypes:Array<String> = ["never", "not singing", "always"];
	var noCapValue:Bool;
	var scheme:Int;

	var tabKeys:Array<String> = [];
	
	var canChangeItems:Bool = true;

	var leftRightCount:Int = 0;

	var iconos:FlxTypedGroup<FlxSprite>;
	var icon:FlxSprite;
	private var perro:FlxSprite = new FlxSprite(100, 0);
	
	var settingText:Array<String> = [
									"Voice of KingFox", 
									"Hottler", 
									"Zombie",
									"Dewott",
									"Nugget",
									"Oz",
									"Zero Animation",
									"Vs Sonic.exe Team",
									"Rozebud"
									];
								
	var settingDesc:Array<String> = [
									"Director - Charts",
									"Sprite Artist",
									"Music Composer",
									"Coder",
									"Menu Artist",
                                    "Background Artist",
                                    "Cutscene",
									"We were given permissions to use endless",
									"Creator of FPS Plus Engine"
									];

	var ghostTapDesc:Array<String> = [
									"Any key press that isn't for a valid note will cause you to miss.", 
									"You can only  miss while you need to sing.", 
									"You cannot miss unless you do not hit a note.\n[Note that this makes the game very easy and can remove a lot of the challenge.]"
									];					

	var controlSchemes:Array<String> = [
									"DEFAULT", 
									"ALT 1", 
									"ALT 2",
									"CUSTOM"
									];

	var controlSchemesDesc:Array<String> = [
									"LEFT: DPAD LEFT / X (SQUARE) / LEFT TRIGGER\nDOWN: DPAD DOWN / X (CROSS) / LEFT BUMPER\nUP: DPAD UP / Y (TRIANGLE) / RIGHT BUMPER\nRIGHT: DPAD RIGHT / B (CIRCLE) / RIGHT TRIGGER", 
									"LEFT: DPAD LEFT / DPAD DOWN / LEFT TRIGGER\nDOWN: DPAD UP / DPAD RIGHT / LEFT BUMPER\nUP: X (SQUARE) / Y (TRIANGLE) / RIGHT BUMPER\nRIGHT: A (CROSS) / B (CIRCLE) / RIGHT TRIGGER", 
									"LEFT: ALL DPAD DIRECTIONS\nDOWN: LEFT BUMPER / LEFT TRIGGER\nUP: RIGHT BUMPER / RIGHT TRIGGER\nRIGHT: ALL FACE BUTTONS",
									"HIT A (CROSS) TO CHANGE CONTROLLER BINDS"
									];

    /*var iconArray:Array<CreditIcon> = [
                                      "Kingfox",
                                      "Hottler",
                                      "Zombie",
                                      "Dewott",
                                      "Nugget",
                                      "Oz",
                                      "Papizero"
                                      ];
									  */
									


	override function create()
	{	
	
		if (FlxG.sound.music == null)
			{
				FlxG.sound.playMusic("assets/music/klaskiiLoop.ogg", 0.75);
			}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuDesat.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1.18));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		bg.color = 0xFF36A303;
		add(bg);
	
		// var magenta = new FlxSprite(-80).loadGraphic('assets/images/menuBGMagenta.png');
		// magenta.scrollFactor.x = 0;
		// magenta.scrollFactor.y = 0;
		// magenta.setGraphicSize(Std.int(magenta.width * 1.18));
		// magenta.updateHitbox();
		// magenta.screenCenter();
		// magenta.visible = false;
		// magenta.antialiasing = true;
		// add(magenta);
		// magenta.scrollFactor.set();
		
		configText = new FlxText(-100, 290, 1280, "", 48);
		configText.scrollFactor.set(0, 0);
		configText.setFormat("assets/fonts/Funkin-Bold.otf", 110, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		configText.borderSize = 3;
		configText.borderQuality = 1;
		
		descText = new FlxText(200, 38, 640, "", 20);
		descText.scrollFactor.set(0, 0);
		descText.setFormat("assets/fonts/vcr.ttf", 40, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//descText.borderSize = 3;
		descText.borderQuality = 1;

		perro.loadGraphic(Paths.image('credits/tequiero'));
		perro.scrollFactor.set(0, 0);
		perro.alpha = 0;
		perro.screenCenter(Y);
		perro.antialiasing = true;
		add(perro);

		tabDisplay = new FlxText(5, FlxG.height - 53, 0, Std.string(tabKeys), 16);
		tabDisplay.scrollFactor.set();
		tabDisplay.visible = false;
		tabDisplay.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		var backText = new FlxText(5, FlxG.height - 37, 0, "ESCAPE - Back to Menu\nENTER - Go to the person's social network\n", 16);
		backText.scrollFactor.set();
		backText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		iconos = new FlxTypedGroup<FlxSprite>();
		add(iconos);

		//@author Bob and Bosip CreditState
		for (i in 0...9) {
		var icon:FlxSprite = new FlxSprite();
		switch (i) {
			case 0: //Kingfox
				icon = new FlxSprite(1133, 245).loadGraphic(Paths.image('credits/iconKingfox'));
			case 1: //Hottler
				icon = new FlxSprite(1133, 345).loadGraphic(Paths.image('credits/iconHottler'));
			case 2: //Zombie
				icon = new FlxSprite(1133, 445).loadGraphic(Paths.image('credits/iconZombie'));
			case 3: //Dewott
				icon = new FlxSprite(1133, 510).loadGraphic(Paths.image('credits/iconDewott'));
			case 4: //Nugget
				icon = new FlxSprite(1133, 605).loadGraphic(Paths.image('credits/iconNugget'));
			case 5: //Oz
				icon = new FlxSprite(1133, 685).loadGraphic(Paths.image('credits/iconOz'));
			case 6: //Zero
				icon = new FlxSprite(1133, 770).loadGraphic(Paths.image('credits/iconPapizero'));
			case 7: //Sonic.sex /j
				icon = new FlxSprite(1133, 850).loadGraphic(Paths.image('credits/iconSonic'));
			case 8: //Rozebud
				icon = new FlxSprite(1133, 930).loadGraphic(Paths.image('credits/iconRoze'));
		}
		icon.setGraphicSize(Std.int(icon.width * 0.5));
		icon.antialiasing = true;
		iconos.add(icon);
	}

		add(configText);
		add(descText);
		add(tabDisplay);
		add(backText);

		textUpdate();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
	
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		
		switch(configSelected){
			case 0: //Kingfox
			if (controls.DOWN_P) {
				canChangeItems = true;	
			}
			if (FlxG.keys.justPressed.H) {
				FlxG.sound.play('assets/sounds/bean' + TitleState.soundExt);
				/* help idk how to code */
			}
			if (controls.UP_P) {
				canChangeItems = false;	
						}
			case 7:
				if (FlxG.keys.justPressed.H) {
					FlxTween.tween(perro,{alpha: 1}, 0.5 ,{ease: FlxEase.expoOut});
					FlxG.sound.play('assets/sounds/vanish' + TitleState.soundExt);
			}
			case 8:
			if (controls.DOWN_P) {
				canChangeItems = false;	
			}
			if (controls.UP_P) {
				canChangeItems = true;	
						}
					}
		if(canChangeItems && !FlxG.keys.pressed.TAB){
			if (controls.UP_P)
				{
					FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
					changeItem(-1);
					perro.alpha = 0;
					configText.y +=80;
					for (item in iconos.members)
						{
					item.y += 80; 
					
				}
			}

				if (controls.DOWN_P)
				{
					FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
					changeItem(1);
					perro.alpha = 0;
					configText.y -=80;
					for (item in iconos.members)
						{
					item.y -= 80; 
				}
			}
				
				switch(configSelected){
                case 0: //Kingfox
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://twitter.com/VOKINGF0X", "&"]);
                        #else
                        FlxG.openURL('https://twitter.com/VOKINGF0X');
                        #end
                    }

                case 1: //Hottler
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://twitter.com/Hottler6", "&"]);
                        #else
                        FlxG.openURL('https://twitter.com/Hottler6');
                        #end
                    }
                case 2: //Zombie
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://twitter.com/XFracturedHuntX", "&"]);
                        #else
                        FlxG.openURL('https://twitter.com/XFracturedHuntX');
                        #end
                    }
                 case 3: //Dewott
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://twitter.com/DewottDev", "&"]);
                        #else
                        FlxG.openURL('https://twitter.com/DewottDev');
                        #end
                    }
                case 4: //Nugget
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://twitter.com/NuggetNightmare", "&"]);
                        #else
                        FlxG.openURL('https://twitter.com/NuggetNightmare');
                        #end
                    }
                case 5: //Zero
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://twitter.com/kleycstreet", "&"]);
                        #else
                        FlxG.openURL('https://twitter.com/kleycstreet');
                        #end
                    }                    
                case 6: //Oz
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://www.youtube.com/channel/UCuUNIUIKMeinlYf2B1LjAEQ/", "&"]);
                        #else
                        FlxG.openURL('https://www.youtube.com/channel/UCuUNIUIKMeinlYf2B1LjAEQ/');
                        #end
					}
				 case 7: //Sonic
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://gamebanana.com/mods/316022", "&"]);
                        #else
                        FlxG.openURL('https://gamebanana.com/mods/316022');
                        #end	
					}

				 case 8: //Roze
                    if (controls.ACCEPT) {
                        #if linux
                        Sys.command('/usr/bin/xdg-open', ["https://gamebanana.com/mods/44201", "&"]);
                        #else
                        FlxG.openURL('https://gamebanana.com/mods/44201');
                        #end	
					}	
			}
		}


		else if(FlxG.keys.pressed.TAB){
			if(FlxG.keys.justPressed.ANY){
				if(FlxG.keys.getIsDown()[0].ID.toString() != "TAB"){
					tabKeys.push(FlxG.keys.getIsDown()[0].ID.toString());
				}		
			}
		}


		if (controls.BACK)
		{
			exit();
		}

		#if debug
		if (FlxG.keys.justPressed.Q)
		{
			canChangeItems = false;
			Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0, iconValue, downValue, randomTapValue, noCapValue);
			FlxG.switchState(new KeyBindQuick());
		}
		#end

		super.update(elapsed);
		
		if(controls.LEFT_P || controls.RIGHT_P || controls.UP_P || controls.DOWN_P || controls.ACCEPT || FlxG.keys.justPressed.ANY)
			textUpdate();
		
	}

	function changeItem(huh:Int = 0)
	{
		configSelected += huh;
			
		if (configSelected > settingText.length - 1)
			configSelected = 0;
		if (configSelected < 0)
			configSelected = settingText.length - 1;
			
	}

	function textUpdate(){

        configText.text = "";



        for(i in 0...settingText.length - 1){

            var textStart = (i == configSelected) ? ">" : "  ";
            configText.text += textStart + settingText[i] + "\n";
        }

		var textStart = (configSelected == settingText.length - 1) ? ">" : "  ";
		configText.text += textStart + settingText[settingText.length - 1] +  "\n";

		descText.text = settingDesc[configSelected];

		tabDisplay.text = Std.string(tabKeys);


    }

	function exit(){
		canChangeItems = false;
		FlxG.sound.music.stop();
		FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
		FlxG.switchState(new MainMenuState());
	}

}
