player = 
{
	x=0;
	y=0;
	w=0;
	h=0;
	tex= love.graphics.newImage("mc.png");
	xvel= 0;
	yvel=0;
	speed=150;
	--varible are the same as enemy.lua with
	--xvel= speed on x axis
	--yvel= speed on y axis
	--speed = the top speed of the player
	--seperating velocity to x/y allow the player to move at any angle
	--instead o n/e/s/w
}

function player:new()
	local tbl ={};
	for key, value in pairs(player) do
		tbl [key] = value
	end
	tbl.w, tbl.h = tbl.tex:getDimensions();
	return tbl;
end

function player:draw()
	love.graphics.draw(self.tex, self.x, self.y);
end	

function player:update(dt)
	self.x=self.x + (self.xvel * dt);
	self.y = self.y + (self.yvel * dt);
	--[[every time update is called we want to move our player
	the player has two velocities (xvel/yvel)
	as well as it's two position coordinates to move the character
	we change the x/y coordinates
	by multiplying the speed of the player by the delta time 
	to ensure it is smooth if we didn't factor in the dt the player
	would move off screen quickly]]

end

function player:hitbox()
	local tbl = {x = self.x, y= self.y, w = self.w, h= self.h};
	return tbl;
	--this gives the hitbox for the player entity, in the form of a table
	--a hitbox is used for collison detection
	--it represents the bounds of the entity
end

function player:input(x,y)
	local startX = self.x + self.w /2;
	local startY = self.y + self.h / 2;
	local angle = math.atan2((y- startY),( x- startX));
	self.xvel = self.speed * math.cos(angle);
	self.yvel = self.speed * math.sin(angle);
	
	--[[every mouse click calculate xvel/yvel
	by getting the angle from player to target
	apply some trigg to factor in topspeed
	now every update player will move to click. 
	player will keep moving wehn the get to point]]
end



