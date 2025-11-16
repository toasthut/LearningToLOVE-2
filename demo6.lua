local Demo6 = Object:extend()

function Demo6:new()
	self.tilemap = {
		{ 1, 6, 6, 2, 1, 6, 6, 2 },
		{ 3, 0, 0, 4, 5, 0, 0, 3 },
		{ 3, 0, 0, 0, 0, 0, 0, 3 },
		{ 4, 2, 0, 0, 0, 0, 1, 5 },
		{ 1, 5, 0, 0, 0, 0, 4, 2 },
		{ 3, 0, 0, 0, 0, 0, 0, 3 },
		{ 3, 0, 0, 1, 2, 0, 0, 3 },
		{ 4, 6, 6, 5, 4, 6, 6, 5 },
	}

	local image = love.graphics.newImage("images/tileset.png")
	self.tileset = {
		image = image,
		quads = {},
		w = image:getWidth(),
		h = image:getHeight(),
	}
	self.tileset.tw = (self.tileset.w / 3) - 2
	self.tileset.th = (self.tileset.h / 2) - 2

	for i = 0, 1 do
		for j = 0, 2 do
			table.insert(
				self.tileset.quads,
				love.graphics.newQuad(
					1 + j * (self.tileset.tw + 2),
					1 + i * (self.tileset.th + 2),
					self.tileset.tw,
					self.tileset.th,
					self.tileset.w,
					self.tileset.h
				)
			)
		end
	end

	self.player = {
		image = love.graphics.newImage("images/player.png"),
		tx = 2,
		ty = 2,
	}

	local song = love.audio.newSource("audio/machine.ogg", "stream")
	song:setVolume(0.45)
	song:setLooping(true)
	song:play()

	self.sfx = love.audio.newSource("audio/fart-trim.ogg", "static")
end

function Demo6:update(dt) end

function Demo6:draw()
	love.graphics.print("Arrow keys to move, Z to attack.", 10, 10)
	local tileset = self.tileset
	for i, row in ipairs(self.tilemap) do
		for j, tile in ipairs(row) do
			if tile ~= 0 then
				love.graphics.draw(tileset.image, tileset.quads[tile], j * tileset.tw, i * tileset.th)
			end
		end
	end

	local player = self.player
	love.graphics.draw(player.image, player.tx * tileset.tw, player.ty * tileset.th)
end

function Demo6:keypressed(key)
	local x = self.player.tx
	local y = self.player.ty

	if key == "left" then
		x = x - 1
	elseif key == "right" then
		x = x + 1
	elseif key == "up" then
		y = y - 1
	elseif key == "down" then
		y = y + 1
	end

	if self:isEmpty(x, y) then
		self.player.tx = x
		self.player.ty = y
	end

	if key == "z" then
		local sfx = self.sfx:clone()
		sfx:play()
	end
end

function Demo6:isEmpty(x, y)
	return self.tilemap[y][x] == 0
end

return Demo6
