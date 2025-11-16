local Demo7 = Object:extend()
local lume = require("lume")

function Demo7:new()
	self.player = {
		x = 100,
		y = 100,
		size = 25,
		speed = 200,
		image = love.graphics.newImage("images/player.png"),
	}

	self.coins = {}
	self.score = 0
	self.shake = {
		timeLeft = 0,
		DURATION = 0.5,
		wait = 0,
		WAIT_DURATION = 0.02,
		offset = { x = 0, y = 0 },
		RANGE = 15,
	}

	if love.filesystem.getInfo("save.dat") then
		local file = love.filesystem.read("save.dat")
		local data = lume.deserialize(file)

		self.player.x = data.player.x
		self.player.y = data.player.y
		self.player.size = data.player.size
		self.player.speed = data.player.speed
		self.score = data.score

		for i, v in ipairs(data.coins) do
			self.coins[i] = {
				x = v.x,
				y = v.y,
				size = 18,
				image = love.graphics.newImage("images/dollar.png"),
			}
		end
	else
		for i = 1, 75 do
			table.insert(self.coins, {
				x = love.math.random(50, love.graphics.getWidth() - 50),
				y = love.math.random(50, love.graphics.getHeight() - 50),
				size = 18,
				image = love.graphics.newImage("images/dollar.png"),
			})
		end
	end
	self.sfx = love.audio.newSource("audio/fart-trim.ogg", "static")
end

function Demo7:update(dt)
	local x = self.player.x
	local y = self.player.y
	local speed = self.player.speed
	local shake = self.shake

	if love.keyboard.isDown("left") then
		x = x - speed * dt
	elseif love.keyboard.isDown("right") then
		x = x + speed * dt
	end

	if love.keyboard.isDown("up") then
		y = y - speed * dt
	elseif love.keyboard.isDown("down") then
		y = y + speed * dt
	end

	self.player.x = x
	self.player.y = y

	for i = #self.coins, 1, -1 do
		if self:checkCollision(self.player, self.coins[i]) then
			table.remove(self.coins, i)
			self.player.size = self.player.size + 1
			self.player.speed = self.player.speed + 10
			self.score = self.score + 1
			shake.timeLeft = shake.DURATION
		end
	end

	if shake.timeLeft > 0 then
		shake.timeLeft = shake.timeLeft - dt
		if shake.wait > 0 then
			shake.wait = shake.wait - dt
		else
			shake.offset.x = love.math.random(-shake.RANGE, shake.RANGE)
			shake.offset.y = love.math.random(-shake.RANGE, shake.RANGE)
			shake.wait = shake.WAIT_DURATION
		end
	end

	self.shake = shake
end

function Demo7:draw()
	local player = self.player

	-- Draw game objects
	love.graphics.push()
	local camx = -player.x + love.graphics.getWidth() / 2
	local camy = -player.y + love.graphics.getHeight() / 2
	love.graphics.translate(camx, camy)

	local shake = self.shake
	if shake.timeLeft > 0 then
		local shakex = shake.offset.x * (shake.timeLeft ^ 2)
		local shakey = shake.offset.y * (shake.timeLeft ^ 2)
		love.graphics.translate(shakex, shakey)
		-- love.graphics.translate(shake.offset.x, shake.offset.y)
	end

	love.graphics.circle("line", player.x, player.y, player.size)
	love.graphics.draw(
		player.image,
		player.x,
		player.y,
		0,
		1,
		1,
		player.image:getWidth() / 2,
		player.image:getHeight() / 2
	)

	for _, v in ipairs(self.coins) do
		love.graphics.circle("line", v.x, v.y, v.size)
		love.graphics.draw(v.image, v.x, v.y, 0, 1, 1, v.image:getWidth() / 2, v.image:getHeight() / 2)
	end
	love.graphics.pop()

	-- Draw UI
	love.graphics.print("F1 to save, F2 to reset.", 10, 10)
	if #self.coins == 0 then
		love.graphics.setNewFont(24)
		local text = "great work soldier"
		love.graphics.print(
			text,
			love.graphics.getWidth() / 2,
			love.graphics.getHeight() / 2,
			0,
			1,
			1,
			love.graphics.getFont():getWidth(text) / 2,
			love.graphics.getFont():getHeight() / 2
		)
		love.graphics.setNewFont()
	end
	love.graphics.print("score: " .. self.score, 10, 30)
end

function Demo7:keypressed(key)
	if key == "z" then
		local sfx = self.sfx:clone()
		sfx:play()
	end

	if key == "f1" then
		self:saveGame()
	elseif key == "f2" then
		love.filesystem.remove("save.dat")
		self:new()
	end
end

function Demo7:checkCollision(p1, p2)
	-- Calculating distance in 1 line
	-- Subtract the x's and y's, square the difference
	-- Sum the squares and find the root of the sum.
	local distance = math.sqrt((p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2)
	-- Return whether the distance is lower than the sum of the sizes.
	return distance < p1.size + p2.size
end

function Demo7:saveGame()
	local data = {}
	local player = self.player
	local coins = self.coins
	local score = self.score

	data.player = {
		x = player.x,
		y = player.y,
		size = player.size,
		speed = player.speed,
	}

	data.coins = {}
	for i, v in ipairs(coins) do
		data.coins[i] = { x = v.x, y = v.y }
	end

	data.score = score

	local serialized = lume.serialize(data)
	love.filesystem.write("save.dat", serialized)
	print("game saved.")
end

return Demo7
