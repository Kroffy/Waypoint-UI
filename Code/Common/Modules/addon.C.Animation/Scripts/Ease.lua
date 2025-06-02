---@class addon
local addon = select(2, ...)
local NS = addon.C.Animation; addon.C.Animation = NS

--------------------------------
-- FUNCTIONS (EASE)
--------------------------------

do
	-- Linear
	function NS.EaseLinear(t, b, c, d)
		return t
	end

	-- Sine
	function NS.EaseSine(t, b, c, d)
		return c * math.sin(t / d * (math.pi / 2)) + b
	end

	-- Out sine
	function NS.EaseOutSine(t, b, c, d)
		return (c - b) * math.sin(t / d * (math.pi / 2)) + b
	end

	-- In out sine
	function NS.EaseInOutSine(t, b, c, d)
		return -(c - b) / 2 * (math.cos(math.pi * t / d) - 1) + b
	end

	-- Quad
	function NS.EaseQuad(t, b, c, d)
		t = t / d
		return -c * t * (t - 2) + b
	end

	-- Quint
	function NS.EaseQuint(t, b, c, d)
		t = t / d - 1
		return c * (t * t * t * t * t + 1) + b
	end

	-- Quart
	function NS.EaseQuart(t, b, c, d)
		t = t / d - 1
		return -c * (t * t * t * t - 1) + b
	end

	-- Cubic
	function NS.EaseCubic(t, b, c, d)
		t = t / d - 1
		return c * (t * t * t + 1) + b
	end

	-- Expo
	function NS.EaseExpo(t, b, c, d)
		if t == d then
			return b + c
		end
		return c * (-2 ^ (-10 * t / d) + 1) + b
	end

	-- Out Expo
	function NS.EaseOutExpo(t, b, c, d)
		if t == d then
			return b + (c - b)
		end
		return (c - b) * (-2 ^ (-10 * t / d) + 1) + b
	end

	-- Elastic
	function NS.EaseElastic(t, b, c, d)
		local p = .3 * d
		local s = p / 4

		if t == 0 then
			return b
		elseif t >= d then
			return b + c
		end

		t = t / d
		return c * (2 ^ (-10 * t) * math.sin((t * d - s) * (2 * math.pi) / p)) + c + b
	end
end
