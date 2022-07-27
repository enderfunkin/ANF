function onBeatHit()
	if curBeat % 2 == 0 then
		setProperty('iconP1.angle', -15);
		setProperty('iconP2.angle', 15);
	else
		setProperty('iconP1.angle', 15);
		setProperty('iconP2.angle', -15);
	end
	doTweenAngle('iconP1Angle', 'iconP1', 0, 0.3, 'quadInOut');
	doTweenAngle('iconP2Angle', 'iconP2', 0, 0.3, 'quadInOut');
end

function onCountdownTick(counter)
	if counter % 2 == 0 then
		setProperty('iconP1.angle', -15);
		setProperty('iconP2.angle', 15);
	else
		setProperty('iconP1.angle', 15);
		setProperty('iconP2.angle', -15);
	end
	doTweenAngle('iconP1Angle', 'iconP1', 0, 0.3, 'quadInOut');
	doTweenAngle('iconP2Angle', 'iconP2', 0, 0.3, 'quadInOut');
end

function onSongStart()
	setProperty('iconP1.angle', -15);
	setProperty('iconP2.angle', 15);
	doTweenAngle('iconP1Angle', 'iconP1', 0, 0.3, 'quadInOut');
	doTweenAngle('iconP2Angle', 'iconP2', 0, 0.3, 'quadInOut');
end