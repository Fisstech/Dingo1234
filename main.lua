require ("enemy");
require ("player");
require ("bush")
 
function love.load()
	-- initialisation happens here
	-- this function will run only once
	--when the app starts
	w, h = love.window.getDimensions();
	love.graphics.setBackgroundColor(215,215,210);
	bgm = love.audio.newSource("Hunter X Hunter (2011) Ost 3 - Riot (Extended).mp3");
	bgm:setLooping(true);
	bgm:play()
	bgm:setVolume(0.3)
	growl = love.audio.newSource("growl.wav", "static");
	
	newGame();
	
end

function love.focus(f) gameIsPaused = not f end
 
function love.update(dt)
	if gameIsPaused then return end -- this pauses the game if its no the active window
	--this function is for updating the game state
	--parameter "dt"- short for Delta Time
	--DeltaTime is the time in MS since last cycle
	--it is used to ensure the game runs smoothly
	print(dt);
	remaining_time = remaining_time - dt 
		if remaining_time <= 0 then
			gameover = true
		end
	if (mc.x >= w - mc.w / 2 or mc.x < 0 - mc.w / 2) then
		gameover = true;
	elseif (mc.y >= h - mc.h / 2 or mc.y < 0 - mc.h / 2) then
		gameover = true;
	end

		
	if not gameover then
		mc:update(dt);
		for key, value in pairs(ents) do
			if (collide(mc:hitbox(), value:hitbox())) then
			table.remove(ents, key);
			growl:play();
			end
		end	
	end
	if (#ents ==10) then gameover = true end;
end

function love.draw()
	--this function is for drawing crap onscreen
		for key, value in pairs(ents) do
			value:draw();
		end
		
		love.graphics.print(remaining_time,0,0)
		mc:draw();
		if gameover then
			love.graphics.setColor(0,0,0);
			love.graphics.print("Game Over \n Press Enter To Try Again!",0,0)
			love.graphics.setColor(255,255,255);
		end
end

function love.keypressed(key)
	--this function is called whenever a key is pressed
	--parameter "key" is what is pressed
	if (key == "escape") then
	love.event.quit();
	elseif (gameover and key == "return") then	
		newGame();
	end
	
end

function love.mousepressed(x, y, btn)
	--this function is called when the mouse is clicked
	--params x, y are the coordinate of the clicked
	--param btn is the button that was clicked. (left click right click)
	mc:input(x,y);
end

function newGame ()
	-- used to start a new game so we don't have to exit and start game again and again
	--could be put in love.load but that only runs once. As an independent function it can run many times.
	remaining_time = 10-- moved this from .love.load to fix instant end after it runs out of time.
		
	ents = {};
	for i=1, 10 do
			--add 10 enemies to ents table as well as bushes
		table.insert(ents, enemy:new());
		table.insert(ents, bush:new());
	end
	
	gameover = false;
	
	mc = player:new(); --mc short for main character
	mc:input(w,h); -- give the mc fake input without fake input character has no direction
	-- it will cause a runtime crash from nil values.
end


function collide(box1, box2)
	return box1.x < box2.x + box2.w and
		   box1.x + box1.w > box2.x and
		   box1.y < box2.y + box2.h and
		   box2.y < box1.y + box1.h 

end




