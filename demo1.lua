local Demo1 = Object:extend()

function Demo1:new()
	self.x = 100
	self.y = 100
	self.radius = 25
	self.speed = 200
end

function Demo1:update(dt)
	self.mx, self.my = love.mouse.getPosition()
	self.angle = math.atan2(self.my - self.y, self.mx - self.x)
	self.cos = math.cos(self.angle)
	self.sin = math.sin(self.angle)

	self.x = self.x + self.speed * self.cos * dt
	self.y = self.y + self.speed * self.sin * dt
end

function Demo1:draw()
	love.graphics.circle("line", self.x, self.y, self.radius)
	love.graphics.print("angle: " .. self.angle, 10, 10)

	love.graphics.line(self.x, self.y, self.mx, self.y)
	love.graphics.line(self.x, self.y, self.x, self.my)
	love.graphics.line(self.x, self.y, self.mx, self.my)
end

return Demo1
