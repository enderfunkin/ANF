package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import haxe.Json;

using StringTools;

typedef MainMenuData = 
{
	var logoP:Array<Int>;
	var storymodeP:Array<Int>;
	var freeplayP:Array<Int>;
	var awardsP:Array<Int>;
	var settingsP:Array<Int>;
	var creditsP:Array<Int>;
	var changelogP:Array<Int>;
	var discordP:Array<Int>;
}

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public var menuItems:Array<Dynamic> = ["story mode", "freeplay", "awards", "settings", "credits", 'changelog', "discord"];
	//var menuItems:FlxTypedGroup<FlxSprite>;
	var magenta:FlxSprite;

	var debugKeys:Array<FlxKey>;
	var mainMenuJson:MainMenuData;

	//Menu items

	var logo:FlxSprite;
	var storyMode:FlxSprite;
	var freePlay:FlxSprite;
	var awards:FlxSprite;
	var settings:FlxSprite;
	var credits:FlxSprite;
	var changeLog:FlxSprite;
	var discord:FlxSprite;

	override function create()
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		mainMenuJson = Json.parse(Paths.getTextFromFile('images/menudata/mainMenu.json'));

		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('anflockin/menuBackgrounds/menuBG'));
		bg.scrollFactor.set();
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('anflockin/menuBackgrounds/menuDesat'));
		magenta.scrollFactor.set();
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
	
		logo = new FlxSprite(mainMenuJson.logoP[0], mainMenuJson.logoP[1]);
		logo.frames = Paths.getSparrowAtlas('anflockin/mainmenu/menu_logo');
		logo.antialiasing = ClientPrefs.globalAntialiasing;
		logo.animation.addByPrefix('bump', 'logo Bumpin', 24, false);
		logo.animation.play('bump');
		logo.updateHitbox();
		add(logo);

		storyMode = new FlxSprite(mainMenuJson.storymodeP[0], mainMenuJson.storymodeP[1]);
		storyMode.frames = Paths.getSparrowAtlas('anflockin/mainmenu/menu_story_mode');
		storyMode.antialiasing = ClientPrefs.globalAntialiasing;
		storyMode.animation.addByPrefix('idle', 'story mode idle', 24, false);
		storyMode.animation.addByPrefix('select', 'story mode select', 24, false);
		storyMode.animation.play('idle');
		storyMode.updateHitbox();
		add(storyMode);

		freePlay = new FlxSprite(mainMenuJson.freeplayP[0], mainMenuJson.freeplayP[1]);
		freePlay.frames = Paths.getSparrowAtlas('anflockin/mainmenu/menu_freeplay');
		freePlay.antialiasing = ClientPrefs.globalAntialiasing;
		freePlay.animation.addByPrefix('idle', 'freeplay idle', 24, false);
		freePlay.animation.addByPrefix('select', 'freeplay select', 24, false);
		freePlay.animation.play('idle');
		freePlay.updateHitbox();
		add(freePlay);

		awards = new FlxSprite(mainMenuJson.awardsP[0], mainMenuJson.awardsP[1]);
		awards.frames = Paths.getSparrowAtlas('anflockin/mainmenu/menu_awards');
		awards.antialiasing = ClientPrefs.globalAntialiasing;
		awards.animation.addByPrefix('idle', 'awards idle', 24, false);
		awards.animation.addByPrefix('select', 'awards select', 24, false);
		awards.animation.play('idle');
		awards.updateHitbox();
		add(awards);

		settings = new FlxSprite(mainMenuJson.settingsP[0], mainMenuJson.settingsP[1]);
		settings.frames = Paths.getSparrowAtlas('anflockin/mainmenu/menu_settings');
		settings.antialiasing = ClientPrefs.globalAntialiasing;
		settings.animation.addByPrefix('idle', 'settings idle', 24, false);
		settings.animation.addByPrefix('select', 'settings select', 24, false);
		settings.animation.play('idle');
		settings.updateHitbox();
		add(settings);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Angry Night Flockin' v" + Application.current.meta.get('version'));
		versionShit.scrollFactor.set();
		versionShit.setFormat("vcr.ttf", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("vcr.ttf", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		discord = new FlxSprite(mainMenuJson.discordP[0], mainMenuJson.discordP[1]);
		discord.frames = Paths.getSparrowAtlas('anflockin/mainmenu/menu_discord');
		discord.antialiasing = ClientPrefs.globalAntialiasing;
		discord.animation.addByPrefix('idle', 'discord idle', 24, false);
		discord.animation.addByPrefix('select', 'discord select', 24, false);
		discord.animation.play('idle');
		discord.updateHitbox();
		add(discord);

		credits = new FlxSprite(mainMenuJson.creditsP[0], mainMenuJson.creditsP[1]);
		credits.frames = Paths.getSparrowAtlas('anflockin/mainmenu/menu_credits');
		credits.antialiasing = ClientPrefs.globalAntialiasing;
		credits.animation.addByPrefix('idle', 'credits idle', 24, false);
		credits.animation.addByPrefix('select', 'credits select', 24, false);
		credits.animation.play('idle');
		credits.updateHitbox();
		add(credits);

		changeLog = new FlxSprite(mainMenuJson.changelogP[0], mainMenuJson.changelogP[1]);
		changeLog.frames = Paths.getSparrowAtlas('anflockin/mainmenu/menu_changelog');
		changeLog.antialiasing = ClientPrefs.globalAntialiasing;
		changeLog.animation.addByPrefix('idle', 'changelog idle', 24, false);
		changeLog.animation.addByPrefix('select', 'changelog select', 24, false);
		changeLog.animation.play('idle');
		changeLog.updateHitbox();
		add(changeLog);

		//menuItems = new FlxTypedGroup<FlxSprite>();
		//add(menuItems);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		var item:String = menuItems[curSelected];

		switch(item)
		{
			case 'story mode':
				storyMode.animation.play('select');
				changeLog.animation.play('idle');
				freePlay.animation.play('idle');
				awards.animation.play('idle');
				settings.animation.play('idle');
				credits.animation.play('idle');
				changeLog.animation.play('idle');
				discord.animation.play('idle');

			case 'freeplay':
				freePlay.animation.play('select');
				storyMode.animation.play('idle');
				changeLog.animation.play('idle');
				awards.animation.play('idle');
				settings.animation.play('idle');
				credits.animation.play('idle');
				changeLog.animation.play('idle');
				discord.animation.play('idle');

			case 'awards':
				awards.animation.play('select');
				freePlay.animation.play('idle');
				storyMode.animation.play('idle');
				changeLog.animation.play('idle');
				settings.animation.play('idle');
				credits.animation.play('idle');
				changeLog.animation.play('idle');
				discord.animation.play('idle');

			case 'settings':
				settings.animation.play('select');
				awards.animation.play('idle');
				freePlay.animation.play('idle');
				storyMode.animation.play('idle');
				changeLog.animation.play('idle');
				credits.animation.play('idle');
				changeLog.animation.play('idle');
				discord.animation.play('idle');

			case 'credits':
				credits.animation.play('select');
				settings.animation.play('idle');
				awards.animation.play('idle');
				freePlay.animation.play('idle');
				storyMode.animation.play('idle');
				changeLog.animation.play('idle');
				discord.animation.play('idle');

			case 'changelog':
				changeLog.animation.play('select');
				credits.animation.play('idle');
				awards.animation.play('idle');
				freePlay.animation.play('idle');
				storyMode.animation.play('idle');
				credits.animation.play('idle');
				discord.animation.play('idle');
			
			case 'discord':
				discord.animation.play('select');
				changeLog.animation.play('idle');
				credits.animation.play('idle');
				awards.animation.play('idle');
				freePlay.animation.play('idle');
				storyMode.animation.play('idle');
				credits.animation.play('idle');
		}
	}

	override function update(elapsed:Float)
	{
		if (!selectedSomethin)
		{
			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}
	
			if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.ACCEPT)
			{
				var itemStr:String = menuItems[curSelected];

				if(itemStr == "discord")
				{
					CoolUtil.browserLoad('https://discord.gg/WSGRVEjX4N');
				}
				else
				{
					selectedSomethin = true;

					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					switch(itemStr)
					{
						case 'story mode':
							MusicBeatState.switchState(new StoryMenuState());
						case 'freeplay':
							MusicBeatState.switchState(new FreeplayState());
						case 'awards':
							MusicBeatState.switchState(new AchievementsMenuState());
						case 'credits':
							MusicBeatState.switchState(new CreditsState());
						case 'settings':
							LoadingState.loadAndSwitchState(new options.OptionsState());
						case 'changelog':
							MusicBeatState.switchState(new ChangeLogState());
					}
				}
			}
		}
	}
}