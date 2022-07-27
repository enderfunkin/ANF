local inCutsceneMatt = true
local inCutsceneTom = true
function onCreate()
	precacheImage('EduardoCUTSCENE')
	precacheImage('character/EddSide')
	precacheImage('character/DEdd')
	-- background shit
	makeLuaSprite('sky', 'SkyBox', -1620, -1000);
	scaleObject('sky', 1.2, 1.2)
	setScrollFactor('sky', 0.3, 0.1);
	
	makeLuaSprite('cloud', 'Clouds', -2590, -500);
	setScrollFactor('cloud', 0.1, 0.3);
	setProperty('cloud.velocity.x', getRandomInt(5, 15));
	
	makeLuaSprite('houses', 'HousesAndFloor', -1790, -600);
	setScrollFactor('houses', 1, 1);
	
	if not lowQuality then
		precacheImage('Mark')
		precacheImage('John')
		precacheImage('DoorOpen')
		precacheImage('Matt')
		precacheImage('Tom')
		
		makeAnimatedLuaSprite('doorOpen', 'DoorOpen', 597, 315); -- from that door on Hard comes up Matt with Tom
		addAnimationByPrefix('doorOpen', 'open', 'Door Opening', 12, false)
		setScrollFactor('doorOpen', 1, 1);
		setProperty('doorOpen.alpha', 0);
		scaleObject('doorOpen', 1.5, 1.5);
	
		makeLuaSprite('city', 'SecondParalax', -1750, -700);
		setScrollFactor('city', 0.7, 0.7);
		
		makeAnimatedLuaSprite('matt', 'Matt', 560, 245); -- matt !!
		addAnimationByPrefix('matt', 'walk', 'MattWalking', 24, true)
		addAnimationByPrefix('matt', 'idle', 'MattSnappingFinger', 24, false)
		addAnimationByPrefix('matt', 'reaction', 'MattReeaction', 24, false)
		addAnimationByPrefix('matt', 'idol', 'MattPISSED', 24, false)
		setScrollFactor('matt', 1, 1);
		setProperty('matt.alpha', 0);
		scaleObject('matt', 1.5, 1.5);
		
		makeAnimatedLuaSprite('tom', 'Tom', 610, 245); -- tom !!
		addAnimationByPrefix('tom', 'walk', 'TomWalkingBy', 24, true)
		addAnimationByPrefix('tom', 'trans', 'TomTransition', 24, false)
		addAnimationByPrefix('tom', 'idle', 'TomIdle', 24, false)
		addAnimationByPrefix('tom', 'lookin', 'TomLooking', 24, false)
		addAnimationByPrefix('tom', 'idol', 'TomIdol', 24, false)
		setScrollFactor('tom', 1, 1);
		setProperty('tom.alpha', 0);
		scaleObject('tom', 1.5, 1.5);
		
		makeLuaSprite('car', 'Car', -1790, -620);
		setScrollFactor('car', 1.35, 1.35);
		
		makeLuaSprite('plane', 'Plane', -890, 0);
		setScrollFactor('plane', 0.2, 0.6);
	end
	
	makeLuaSprite('fence', 'Fence', -1790, -600);
	setScrollFactor('fence', 1, 1);

	addLuaSprite('sky', false); --bg
	addLuaSprite('cloud', false);
	addLuaSprite('plane', false);
	addLuaSprite('city', false);
	addLuaSprite('houses', false);
	addLuaSprite('doorOpen', false);
	
	addLuaSprite('fence', false); --fence lol
	
	addLuaSprite('matt', false); -- matt
	addLuaSprite('tom', false); -- tom
	
	addLuaSprite('car', true);
end

function onBeatHit()
	if curBeat % 2 == 0 and not inCutsceneTom then --940
		if mustHitSection then
			objectPlayAnimation('tom', 'idle', true);
		elseif not mustHitSection then
			objectPlayAnimation('tom', 'idol', true);
		end
	end
	if curBeat % 2 == 0 and not inCutsceneMatt then
		objectPlayAnimation('matt', 'idle', true);
	end
	if curBeat == 32 then
		objectPlayAnimation('doorOpen', 'open', true)
		setProperty('doorOpen.alpha', 1);
		runTimer('doorGoesInvis', 1, 1)
		setProperty('matt.alpha', 1);
		doTweenX('MattTweenX', 'matt', 10, 2);
	end
	if curBeat == 64 then
		setProperty('doorOpen.alpha', 1);
		objectPlayAnimation('doorOpen', 'open', true)
		runTimer('doorGoesInvis', 1, 1)
		setProperty('tom.alpha', 1);
		setProperty('tom.flipX', true);
		doTweenX('tomTweenX', 'tom', 1390, 4);
	end
end

function onTweenCompleted(tag)
	if tag == 'MattTweenX' then
		inCutsceneMatt = false
		objectPlayAnimation('matt', 'idle', true)
		setProperty('matt.x', -80); -- offset
	end
	if tag == 'tomTweenX' then
		inCutsceneTom = false
		objectPlayAnimation('tom', 'trans', true);
		setProperty('tom.flipX', false);
	end
end


function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'doorGoesInvis' then
		setProperty('doorOpen.alpha', 0);
	end
end