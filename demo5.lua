local Demo5 = Object:extend()

function Demo5:new()
	self.tilemap = {
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 1, 2, 2, 2, 2, 2, 2, 2, 2, 1 },
		{ 1, 2, 3, 4, 5, 5, 4, 3, 2, 1 },
		{ 1, 3, 3, 4, 5, 5, 4, 3, 3, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	}

	self.colors = {
		{ 1, 1, 1 },
		{ 1, 0, 0 },
		{ 1, 0, 1 },
		{ 0, 0, 1 },
		{ 0, 1, 1 },
	}

	self.image = love.graphics.newImage("images/tile.png")
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function Demo5:update(dt) end

function Demo5:draw()
	for i, row in ipairs(self.tilemap) do
		for j, tile in ipairs(row) do
			if tile ~= 0 then
				love.graphics.setColor(self.colors[tile])
				love.graphics.rectangle("fill", j * 25, i * 25, 25, 25)
			end
		end
	end

	for i, row in ipairs(self.tilemap) do
		for j, tile in ipairs(row) do
			if tile ~= 0 then
				love.graphics.setColor(self.colors[tile])
				love.graphics.draw(self.image, j * self.width, i * self.height + 175)
			end
		end
	end
end

return Demo5
