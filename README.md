Updated With QKI2 See RG Lua area for details for now as i have not the time to update this text. 


# QKI
Quicky Kiss It is a lua script for use with kissassist. 

This has to be used while kissassist is running. Has a pause and start kiss buttons.

Download>Place in your lua folder> type: /lua run qki > Click check boxes. 

-- Quicky Kiss It V1 By MotoJeff. A clunky little lua GUI that allows on the fly modification to KissAssist ini variables and stuff.--



The idea behind this is to allow to quickly modify kiss variables in game on the fly with a simple click when game play situations change per character running KissAssist.

 

For example:



Maybe I want the bard to ae mez some fights and not at all for others and single target mez for some fights, with this I can just check or uncheck what I want to do.



Maybe I want the rogue to autohide, but then want to turn it off later, or I want the druid to make a campfire and use group escape for a certain camp just check the box.



Want the ranger to melee one fight then range the next? check or uncheck the box.



Want to chase? check the box. Stop chase? uncheck the box.



Need to med in combat for a few pulls? check the box. I think you get it.



Set up your normal kissassist ini file for your toon, run kissassist in game, load QKI.lua, and check your boxes.

The check box variables and what they do match kissassist, if you are not sure what these do please refer to the kissassist wiki, generally they are setting the variable to 1 or 0 even if there are alternate options for the variable. With the exception of the single mez and the ae mez check boxes single is 1/0, ae is 2/0.
The buttons are as follows for now:
Pause/Resume the macro.
Restart kiss with no role (should target your ma before clicking).
Force Rebuff, same as force rebuff command in kiss.
Start kiss as puller role (should target ma when you click and have your pull section set up in your ini).
STAHP!! will try and stop you with something like this: (/squelch /multiline ; /end; /afollow off; /stick off; /moveto off; /nav stop; /play off; /mqp on; /attack off; /twist off;). figured it could be handy.


**V1 does not import any existing settings from the INI. At start up it will default to all unchecked in the lua, and will do whatever is saved in your ini until you check a box in the gui.



Checking boxes that don't have defined variables in your kiss ini might cause cause errors or lua to end. for example turning on and off use pet, or twist for a class that doesn't use a pet or twist most likely nothing will happen and you will just see errors in the mq console.



Yes you can just type the commands to do this, you can even create a bunch of buttons or hot keys to do this just as well but thought some people might find it useful. I know most have buttons for stuff like this set up from their driving character and this script my not be useful but if you like to bounce around between characters you might find this helpful.



This is one of my first attempts at creating something with imgui in lua, the overall script is still buggy and has some kinks to workout like:



Layout as of now is narrow and wide I like to keep it at the top or bottom of the screen so it fits my play style, but I plan to make it scale similar to how the button master lua does so it can fit to anyone's liking.
Might try and get it to load existing settings from your kiss ini to start with so.
Might add functionality to input values and commit/save the changes to the toons loaded kiss ini from the gui for example change your pull radius or stuff like that.
Might break up the lua file so that its not all just mashed into one file.
Might abandon this right after this post and disappear from eq/rg for 5-15 years.. or I might try and grow into something nice, you never know.
Needs more testing/tuning.
Needs more tuning/testing.
Needs more check boxes maybe even sprinkle in some more buttons.

