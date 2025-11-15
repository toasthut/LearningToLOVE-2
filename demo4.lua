local Demo4 = Object:extend()

function Demo4:new()
	self.image = love.graphics.newImage("images/rat-strut.png")
	local width = self.image:getWidth()
	local height = self.image:getHeight()

	self.frames = {}

	local frameWidth = 31
	local frameHeight = 48

	local maxFrames = 8
	for i = 0, 2 do
		for j = 0, 2 do
			table.insert(
				self.frames,
				love.graphics.newQuad(
					1 + j * (frameWidth + 2),
					1 + i * (frameHeight + 2),
					frameWidth,
					frameHeight,
					width,
					height
				)
			)
			if #self.frames >= maxFrames then
				break
			end
		end
	end
	self.currentFrame = 1
end

function Demo4:update(dt)
	self.currentFrame = self.currentFrame + 12.8 * dt
	if self.currentFrame >= #self.frames + 1 then
		self.currentFrame = 1
	end
end

function Demo4:draw()
	love.graphics.print("frame: " .. self.currentFrame, 10, 10)
	love.graphics.draw(self.image, self.frames[math.floor(self.currentFrame)], 100, 100, 0, 5, 5)
	love.graphics.draw(self.image, 400, 100)
end

return Demo4
