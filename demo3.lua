local Demo3 = Object:extend()

function Demo3:new()
	self.x = 200
	self.y = 200
	self.speed = 300
	self.angle = 0
	self.image = love.graphics.newImage("images/arrow_right.png")
	self.ox = self.image:getWidth() / 2
	self.oy = self.image:getHeight() / 2
end

function Demo3:update(dt)
	self.mx, self.my = love.mouse.getPosition()
	self.angle = math.atan2(self.my - self.y, self.mx - self.x)
	local cos = math.cos(self.angle)
	local sin = math.sin(self.angle)

	self.x = self.x + self.speed * cos * dt
	self.y = self.y + self.speed * sin * dt
end

function Demo3:draw()
	love.graphics.draw(self.image, self.x, self.y, self.angle, 1, 1, self.ox, self.oy)
	love.graphics.circle("fill", self.mx, self.my, 5)
end

return Demo3
