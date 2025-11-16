---@diagnostic disable: lowercase-global
io.stdout:setvbuf("no")

Object = require("classic")
local Demo1 = require("demo1")
local Demo2 = require("demo2")
local Demo2_1 = require("demo2_1")
local Demo3 = require("demo3")
local Demo4 = require("demo4")
local Demo5 = require("demo5")
local Demo6 = require("demo6")
local Demo7 = require("demo7")

function love.load()
	love.graphics.setDefaultFilter("nearest")
	demos = { Demo1, Demo2, Demo2_1, Demo3, Demo4, Demo5, Demo6, Demo7 }
	currentDemo = nil
end

function love.update(dt)
	if currentDemo == nil then
		return
	end
	currentDemo:update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(0, 0, 0, 0)
	if currentDemo == nil then
		love.graphics.print("Press a number key [1-" .. #demos .. "] to pick a demo.", 10, 10)
		return
	end
	currentDemo:draw()
end

function love.keypressed(key)
	for i, v in ipairs(demos) do
		if key == tostring(i) then
			love.audio.stop()
			currentDemo = v()
			print("demo " .. i .. " selected")
			break
		end
	end

	if currentDemo ~= nil then
		pcall(currentDemo.keypressed, currentDemo, key)
	end
end
