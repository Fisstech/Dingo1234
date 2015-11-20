enemy = 
{
	x = 0 ;
	y = 0;
	tex = love.graphics.newImage("enemy.png");
	w = 0;
	h = 0;
	--x/y are position coordinates
	--tex is texture/ appearence
	--w/h are the width and height of enemy
}


function enemy : new()
	--to make a new enemy entity, we have this method
	--the method creates a temporary table
	-- it copies everything from enemy table int otemp table
	-- this includes functions in table(draw,hitbox,new)
	--functions are still values in lua
	--at the same time we set the entitys width and length to 
	--real numbers useing getDimensions
	--last we give the enemy instance a random location for variety
	
	local tbl= {} ;
	for key, value in pairs(enemy) do
		tbl[key] = value;
	
	end
	
	math.randomseed(math.random(os.time()));
	tbl.w, tbl.h = tbl.tex:getDimensions();
	tbl.x = math.random(w - tbl.w);
	tbl.y = math.random(h - tbl.h);
	return tbl;
end	

function enemy : draw()
	--draw enemy at location
	love.graphics.draw(self.tex, self.x, self.y);
end

function enemy : hitbox()
	local tbl = {x = self.x, y= self.y, w = self.w, h= self.h};
	return tbl;
	--this gives the hitbox for the enemy entity, in the form of a table
	--a hitbox is used for collison detection
	--it represents the bounds of the entity
end


