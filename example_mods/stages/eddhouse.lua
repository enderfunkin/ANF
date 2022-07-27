local inCutscene = false
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
	
	makeAnimatedLuaSprite('gff', 'Girlfriend', 450, 125);
	addAnimationByPrefix('gff', 'first', 'GF Dancing Beat Left', 24, false);
	addAnimationByPrefix('gff', 'second', 'GF Dancing Beat Right', 24, false);
	setObjectOrder('gff', 1)
	setScrollFactor('gff', 1, 1);
	
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
		setObjectOrder('matt', 1)
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
		addAnimationByPrefix('tom', 'reaction', 'TomReaction', 24, false)
		setScrollFactor('tom', 1, 1);
		setProperty('tom.alpha', 0);
		scaleObject('tom', 1.5, 1.5);
		
		makeAnimatedLuaSprite('john', 'John', -915, 205); -- john
		addAnimationByPrefix('john', 'idle', 'JohnIdle', 24, false)
		setScrollFactor('john', 1, 1);
		setProperty('john.alpha', 0);
		scaleObject('john', 0.9, 0.9);
		
		makeAnimatedLuaSprite('mark', 'Mark', -760, 245); -- mark
		addAnimationByPrefix('mark', 'idle', 'MarkIdle', 24, false)
		setScrollFactor('mark', 1, 1);
		setProperty('mark.alpha', 0);
		scaleObject('mark', 0.8, 0.8);
		
		makeLuaSprite('car', 'Car', -1790, -620);
		setScrollFactor('car', 1.35, 1.35);
		
		makeLuaSprite('plane', 'Plane', -890, 0);
		setScrollFactor('plane', 0.2, 0.6);
	end
	
	makeLuaSprite('fence', 'Fence', -1790, -600);
	setObjectOrder('fence', 1)
	setScrollFactor('fence', 1, 1);
		
	makeAnimatedLuaSprite('cutscene', 'eduardo punch/cutscene', -1115, 105,'tex'); -- eduardo punches john, cry about it =l
	addAnimationByPrefix('cutscene', 'cutscene', 'cutscene', 24, false)
	setScrollFactor('cutscene', 1, 1);
	setProperty('cutscene.alpha', 0);
	

	addLuaSprite('sky', false); --bg
	addLuaSprite('cloud', false);
	addLuaSprite('plane', false);
	addLuaSprite('city', false);
	addLuaSprite('houses', false);
	addLuaSprite('doorOpen', false);
	
	addLuaSprite('mark', false); --dumbasses
	addLuaSprite('john', false);
	addLuaSprite('cutscene', false);
	addLuaSprite('fence', false); --fence lol
	
	addLuaSprite('matt', false); -- matt
	addLuaSprite('tom', false); -- tom
	addLuaSprite('gff', false); -- sprite gf
	
	addLuaSprite('car', true);
end

function onStepHit()
	if curStep % 4 == 2 then
		objectPlayAnimation('gff', 'first', true);
		setProperty('gff.y', 125)
	end
	if curStep % 8 == 2 then
		objectPlayAnimation('gff', 'second', true);
		setProperty('gff.y', 130)
	end
	if curStep == 144 then -- tord plane comin
		doTweenX('PlaneTweenX', 'plane', 1600, 25);
	end
	if curStep == 272 then -- matt coming up
		objectPlayAnimation('doorOpen', 'open', true)
		setProperty('doorOpen.alpha', 1);
		runTimer('doorGoesInvis', 1, 1)
		setProperty('matt.alpha', 1);
		doTweenX('MattTweenX', 'matt', 10, 1.9);
		function onTimerCompleted(tag, loops, loopsLeft)
			if tag == 'doorGoesInvis' then
				setProperty('doorOpen.alpha', 0);
			end
		end
	end
	if curStep == 416 then -- tom coming up
		setProperty('doorOpen.alpha', 1);
		objectPlayAnimation('doorOpen', 'open', true)
		runTimer('doorGoesInvis', 1, 1)
		setProperty('tom.alpha', 1);
		setProperty('tom.flipX', true);
		doTweenX('tomTweenX', 'tom', 1390, 4.8);
		function onTimerCompleted(tag, loops, loopsLeft)
			if tag == 'doorGoesInvis' then
				setProperty('doorOpen.alpha', 0);
			end
		end
	end
	if curStep == 928 then -- well
		setProperty('eddI.visible', true)
		doTweenAlpha('SkyTweenAlpha', 'sky', 0.9, 0.2);
		doTweenZoom('ZoominToNeighbours', 'camGame', 0.75, 0.2);
	end
	if curStep == 932 then -- well
		doTweenAlpha('SkyTweenAlpha2', 'sky', 0.8, 0.2);
		doTweenZoom('ZoominToNeighbours2', 'camGame', 0.8, 0.2);
	end
	if curStep == 936 then -- well
		doTweenAlpha('SkyTweenAlpha3', 'sky', 0.7, 0.2);
		doTweenZoom('ZoominToNeighbours3', 'camGame', 0.9, 0.2);
		runTimer('SkyToNormal', 1, 1)
		function onTimerCompleted(tag, loops, loopsLeft)
			if tag == 'SkyToNormal' then
				doTweenAlpha('SkyTweenAlpha4', 'sky', 1, 2);
			end
		end
	end
	if curStep == 1599 then -- but i didnt even said anything
		setProperty('gf.visible', false)
		removeLuaSprite('mark')
		removeLuaSprite('john')
		setProperty('cutscene.alpha', 1);
		objectPlayAnimation('cutscene', 'cutscene', true)
	end
end -- hello im serdzhant

function onBeatHit()
	if curBeat % 2 == 0 and curStep > 478 and not inCutscene then --940
		if mustHitSection then
			objectPlayAnimation('tom', 'idle', true);
		elseif not mustHitSection then
			objectPlayAnimation('tom', 'idol', true);
		end
	end
	if curBeat % 2 == 0 and curStep > 289 and curStep < 912 then
		objectPlayAnimation('matt', 'idle', true);
	end
	if curBeat == 228 then
		inCutscene = true
		doTweenAlpha('hudFunne', 'camHUD', 0, 0.6, 'linear')
		objectPlayAnimation('tom', 'reaction', true);
		objectPlayAnimation('matt', 'reaction', true);
		setProperty('matt.x', -26); -- offset
		setProperty('john.alpha', 1);
		setProperty('mark.alpha', 1);
	end
	if curBeat % 2 == 0 and curStep > 940 then
		inCutscene = false
		objectPlayAnimation('matt', 'idol', true);
		setProperty('matt.x', -80); -- offset
		objectPlayAnimation('john', 'idle', true);
		objectPlayAnimation('mark', 'idle', true);
	end
	if curBeat == 236 then
		doTweenAlpha('hudFunne', 'camHUD', 1, 0.2, 'linear')
	end
	if curBeat == 398 then -- cutscene ending
		doTweenAlpha('hudFunne', 'camHUD', 0, 0.4, 'linear') -- ALEX DIRECTOR WROTE THIS WOOO-
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if boyfriendName == 'bf' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'bf');
	end
	if noteType == 'Opponent Sing' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'edd-dead');
	end
end

function onTweenCompleted(tag)
	if tag == 'PlaneTweenX' then
		removeLuaSprite('plane', true); -- optimization
	end
	if tag == 'MattTweenX' then
		objectPlayAnimation('matt', 'idle', true)
		setProperty('matt.x', -80); -- offset
	end
	if tag == 'tomTweenX' then
		objectPlayAnimation('tom', 'trans', true);
		setProperty('tom.flipX', false);
	end
end

function onCountdownTick(counter)
	if counter == 0 then
		objectPlayAnimation('gff', 'first', true);
		setProperty('gff.y', 125)
	end
	if counter == 1 then
		objectPlayAnimation('gff', 'second', true);
		setProperty('gff.y', 130)
	end
	if counter == 2 then
		objectPlayAnimation('gff', 'first', true);
		setProperty('gff.y', 125)
	end
	if counter == 3 then
		objectPlayAnimation('gff', 'second', true);
		setProperty('gff.y', 130)
	end
	if counter == 4 then
		objectPlayAnimation('gff', 'first', true);
		setProperty('gff.y', 125)
	end
end

function onCreatePost()
	if not hideHud then
	makeLuaSprite('eddI', 'edd', getProperty('iconP1.x'), getProperty('iconP1.y'))
	setObjectCamera('eddI', 'hud')
	addLuaSprite('eddI', true)
	setObjectOrder('eddI', getObjectOrder('iconP1') + 1)
	setProperty('eddI.flipX', true)
	setProperty('eddI.visible', false)
	end
end

function onUpdatePost(elapsed)
	if not hideHud then
	setProperty('eddI.x', getProperty('iconP1.x') + 50)
	setProperty('eddI.angle', getProperty('iconP1.angle'))
	setProperty('eddI.y', getProperty('iconP1.y') - 50)
	setProperty('eddI.scale.x', getProperty('iconP1.scale.x') - 0.3)
	setProperty('eddI.scale.y', getProperty('iconP1.scale.y') - 0.3)
	end
end