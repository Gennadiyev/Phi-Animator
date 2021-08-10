local function pow(a, b)
    return a ^ b
end

local easingDictionary = {
	linear = 0,
	inSine = 1,
	outSine = 2,
	inOutSine = 3,
	inCubic = 4,
	outCubic = 5,
	inOutCubic = 6,
	inQuint = 7,
	outQuint = 8,
	inOutQuint = 9,
	inCirc = 10,
	outCirc = 11,
	inOutCirc = 12,
	zero = 13,
	one = 14
}

local function lerp(time1, time2, currentTime, param1, param2, easeType)
	local t = currentTime - time1
	local b = param1
	local c = param2 - param1
	local d = time2 - time1
	if easeType == 0 then -- Linear
		return c * t / d + b
	elseif easeType == 1 then -- Ease in sine
		return -c / 2 * (math.cos(math.pi * t / d) - 1) + b
	elseif easeType == 2 then -- Ease out sine
		return c * math.sin(t / d * (math.pi / 2)) + b
	elseif easeType == 3 then -- Ease in and out sine
		return -c / 2 * (math.cos(math.pi * t / d) - 1) + b
	elseif easeType == 4 then -- Ease in cubic
		t = t / d
		return c * pow(t, 3) + b
	elseif easeType == 5 then -- Ease out cubic
		t = t / d - 1
		return c * (pow(t, 3) + 1) + b
	elseif easeType == 6 then -- Ease in and out cubic
		t = t / d * 2
		if t < 1 then
		    return c / 2 * t * t * t + b
		else
    		t = t - 2
			return c / 2 * (t * t * t + 2) + b
		end
	elseif easeType == 7 then -- Ease in quint
		t = t / d
		return c * pow(t, 5) + b
	elseif easeType == 8 then -- Ease out quint
		t = t / d - 1
		return c * (pow(t, 5) + 1) + b
	elseif easeType == 9 then -- Ease in and out quint
		t = t / d * 2
		if t < 1 then	  
			return c / 2 * pow(t, 5) + b
		else
		  	t = t - 2
		  	return c / 2 * (pow(t, 5) + 2) + b
		end
	elseif easeType == 10 then -- Ease in circ
		t = t / d
		return(-c * (math.sqrt(1 - pow(t, 2)) - 1) + b)
	elseif easeType == 11 then -- Ease out circ
		t = t / d - 1
		return(c * math.sqrt(1 - pow(t, 2)) + b)
	elseif easeType == 12 then -- Ease in and out circ
		t = t / d * 2
		if t < 1 then
		    return -c / 2 * (math.sqrt(1 - t * t) - 1) + b
		else
		    t = t - 2
		    return c / 2 * (math.sqrt(1 - t * t) + 1) + b
		end
	elseif easeType == 13 then -- Zero
		return param1
	elseif easeType == 14 then -- One
		return param2
	end
end

return easingDictionary, lerp