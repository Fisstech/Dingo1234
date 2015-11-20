bush = 
{
	x = 0 ;
	y = 0;
	tex = love.graphics.newImage("bush.png");
	w = 0;
	h = 0;
	--x/y are position coordinates
	--tex is texture/ appearence
	--w/h are the width and height of bush
}


function bush : new()
	--to make a new bush entity, we have this method
	--the method creates a temporary table
	-- it copies everything from bush table into a temp table
	-- this includes functions in table(draw,hitbox,new)
	--functions are still values in lua
	--at the same time we set the entitys width and length to 
	--real numbers using getDimensions
	--last we give the bush instance a random location for variety
	
	local tbl= {} ;
	for key, value in pairs(bush) do
		tbl[key] = value;
	
	end
	
	math.randomseed(math.random(os.time()));
	tbl.w, tbl.h = tbl.tex:getDimensions();
	tbl.x = math.random(w - tbl.w);
	tbl.y = math.random(h - tbl.h);
	return tbl;
end	

function bush : draw()
	--draw bush at location
	love.graphics.draw(self.tex, self.x, self.y);
end

--[[]]

function bush : hitbox()
	local tbl = {x = 1000, y= 1000, w = 1000, h= 1000};
	return tbl;
	--this gives the hitbox for the bush entity, in the form of a table
	--a hitbox is used for collison detection
	--it represents the bounds of the entity
end

