local Demo2_1 = Object:extend()

function Demo2_1:new()
	self.x = 100
	self.y = 100
	self.radius = 25
	self.maxDist = 350
end

function Demo2_1:update(dt)
	self.mx, self.my = love.mouse.getPosition()
	self.angle = math.atan2(self.my - self.y, self.mx - self.x)
	local cos = math.cos(self.angle)
	local sin = math.sin(self.angle)

	local distance = Demo2_1:getDistance(self.x, self.y, self.mx, self.my)

	local speed = (math.max(self.maxDist - distance, 0) / 10) ^ 2
	self.x = self.x + speed * cos * dt
	self.y = self.y + speed * sin * dt
end

function Demo2_1:draw()
	love.graphics.circle("line", self.x, self.y, self.radius)
	love.graphics.line(self.x, self.y, self.mx, self.my)

	local distance = Demo2_1:getDistance(self.x, self.y, self.mx, self.my)
	love.graphics.circle("line", self.x, self.y, self.maxDist)
	love.graphics.print("distance: " .. distance, 10, 10)
end

function Demo2_1:getDistance(x1, y1, x2, y2)
	local h_distance = x1 - x2
	local v_distance = y1 - y2

	local a = h_distance ^ 2
	local b = v_distance ^ 2

	local c = a + b
	local distance = math.sqrt(c)
	return distance
end

return Demo2_1
