-- artking script by Aron#6810
for _,modulo in next,{"disableAfkDeath","disableAutoNewGame","disableAutoScore","disableAutoShaman","disableAutoTimeLeft","disablePhysicalConsumables"} do
    tfm.exec[modulo](true)
end
admins = {["Aron#6810"] = true , ["Wassim_pro#1386"] = true , ["Crawen#1820"] = true , ["Walllid#0000"] = true , ["Buu#1879"] = true}
p = {}
banned = {}
drow = {}
subjects = {"ciger","crescent","cheese","clouds","shoe","burger","shark","hat","house","bed","doll","cup","coin","strawberry","banana","apple","tree","phone","potato","earth","mars","traffic light"}
tfm.exec.newGame("@7783037")
canAns = false
candr = false
local drawer = 0
local sub =  0
function module()
    players = {}
    for name , player in next, tfm.get.room.playerList do
        table.insert(players,name)
        drow[name] = false
    end
    tfm.exec.setUIMapName("<ch> A painter is chosen ... </ch>")
end
 
chose = 0
function eventLoop(past,left)
    chose = chose + 1
    if left < 1000 then
        tfm.exec.newGame("@7783037")
    end
    if chose == 20 then
        drower()
    end
end
 
function drower()
    drawer = math.random(#players)
    sub = math.random(#subjects)
    if not banned[players[drawer]] then
        drow[players[drawer]] = true
        tfm.exec.killPlayer(players[drawer])
        tfm.exec.chatMessage("<vp> Time to guess what drawing the painter will make !!!")
        tfm.exec.setUIMapName("<ch>Painter :</ch>".. " " .. players[drawer])
        ui.addTextArea(0, "<p align='center'><font size='23'> The drawing you should draw is : " .. " " .. subjects[sub] , players[drawer], 7, 34, 788, 56, 0x0d171c, 0x000000, 1, true)
        ui.addTextArea(2, "<a href='event:clear'><p align='center'>C", players[drawer], 11, 316, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        ui.addTextArea(1, "<a href='event:color'>                                                                 \n                                                                                          \n                                          ", players[drawer], 9, 343, 40, 52,uicolor, 0xc9db00, 1, true)
        ui.addTextArea(3, "<a href='event:-'><p align='center'><b>-", players[drawer], 11, 287, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        ui.addTextArea(4, "<a href='event:+'><p align='center'><b>+", players[drawer], 11, 260, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        system.bindMouse(players[drawer],true)
        canAns = true
        candr = true
    else
        tfm.exec.setUIMapName("<ch>Painter: Painter was banned ...</ch>")
        tfm.exec.setGameTime(0,true)
    end
end
 
function eventNewGame()
    for name , player in next, tfm.get.room.playerList do
        system.bindMouse(name,false)
        if admins[name] then
            tfm.exec.setNameColor(name,0xFF0000)
        end
    end
    for _,remove in next,{0,1,2,3,4} do
        ui.removeTextArea(remove,nil)
    end
    for id = 4,id do
        ui.removeTextArea(id,nil)
    end
    sub = math.random(#subjects)
    module()
    chose = 0
    canAns = false
    candr = false
end
 
sub = math.random(#subjects)
 
function eventChatMessage(name,message)
    if message == subjects[sub] then
        p[name].ban = p[name].ban + 1
        if p[name].ban == 1 then
            tfm.exec.chatMessage("<r> Warning : You cannot share the answers with other people (1/2)",name)
        end
        if p[name].ban == 2 then
            tfm.exec.chatMessage("<r> Warning : You cannot share the answers with other people  (2/2) you have been banned",name)
            ui.addTextArea(999910009, "",name, -404, -137, 1576, 874, 0x040505, 0x000000, 1, true)
            banned[name] = true
        end
    end
end
 
id = 6
size1 = 14
size2 = 16
function eventMouse(name,x,y)
    id = id + 1
    ui.addTextArea(id, "", nil, x , y , size1, size2, uicolor, uicolor, 1, false)
end
 
function eventChatCommand(name,command)
    local args = {}
    for name in command:gmatch("%S+") do
        table.insert(args, name)
    end
    if admins[name] then
        if args[1] == "time" then
            tfm.exec.setGameTime(tonumber(args[2]),true)
        elseif args[1] == "ban" then
            banned[args[2]] = true
            ui.addTextArea(1000000000000000000, "",args[2], -404, -137, 1576, 874, 0x040505, 0x000000, 1, true)
            tfm.exec.chatMessage("<r> the player  :" .. "  " .. args[2] .. " has been baneed \n" .. " " .. "the reason : " .. " " .. args[3])
        elseif args[1] == "warn" then
            tfm.exec.chatMessage("<r> You have been warned that you are breaking a pattern rule",args[2])
        end
    end
    if canAns == true then
        if command == "an"  then
            if not drow[name] then
                ui.addPopup(1,2,"<p align='center'> Write your prediction here !",name, 7, 34, 788,true)
            else
                tfm.exec.chatMessage("<r> You are the painter, you cannot answer !!!",name)
            end
        end
    end 
end
 
click = os.time()
clear_time = os.time()
function eventTextAreaCallback(id,name,callback)
    if callback ==  "color" then
        ui.showColorPicker(1,name,0,"Choose your painter's color")
    elseif callback == "+" then
        size1 = size1 + 3
        size2 = size2 + 3
    elseif callback == "-" then
        if click+2000 < os.time() then
            size1 = size1 - 3
            size2 = size2 - 3
            if size1 == -4 then
                size1 = 11
            end
            if size2 == -2 then
                size2 = 13
            end
            click = os.time()
        end
        print(size1 .. size2)
    elseif callback == "clear" then
        if clear_time+2000 < os.time() then
            for id = 5,999 do
                ui.removeTextArea(id,nil)
            end
            id = 5
            clear_time = os.time()
        end
    end
end
 
 
sub = math.random(#subjects)
function eventPopupAnswer(id, name, answer)
    if id == 1 then
        if answer == subjects[sub] then
            tfm.exec.chatMessage("<vp> You have answered correctly Congratulations ! "..name.."",nil)
            tfm.exec.giveCheese(name)
            tfm.exec.playerVictory(name)
        else
            tfm.exec.chatMessage("<r> wrong answer :( </r>",name)
        end
    end
end
 
function eventColorPicked(id, name, color)
    uicolor = color
    if candr == true then
        ui.addTextArea(1, "<a href='event:color'>                                                                 \n                                                                                          \n                                          ", name, 9, 343, 40, 52,uicolor, 0xc9db00, 1, true)
    end
end
 
function eventNewPlayer(name)
    if not p[name] then
        p[name] = {ban = 0}
    end
    tfm.exec.chatMessage("<vp> welcome to artking \n https://atelier801.com/topic?f=6&t=892662 ",name)
    if banned[name] then
        ui.addTextArea(1000000000000000000, "",name, -404, -137, 1576, 874, 0x040505, 0x000000, 1, true)
    end
    if admins[name] then
        tfm.exec.setNameColor(name,0xFF0000)
    end
end
 
function eventPlayerLeft(name)
    if drow[name] then
        tfm.exec.chatMessage("<r> The painter has left the room Moving to the next round  ...")
        tfm.exec.setGameTime(0,true)
        drow[name] = false
    end
end
 
function eventPlayerWon(name)
    local alive = 0
    for name, player in next, tfm.get.room.playerList do
        if not player.isDead then
            alive = alive + 1
        end
    end
    if alive == 0 then
        tfm.exec.setGameTime(0,true)
        tfm.exec.chatMessage("<r> Warning: There are not enough players to continue")
    end
end
 
function eventPlayerDied(name)
    local alive = 0
    for name, player in next, tfm.get.room.playerList do
        if not player.isDead then
            alive = alive + 1
        end
    end
    if alive == 0 then
        tfm.exec.setGameTime(0,true)
        tfm.exec.chatMessage("<r> Warning: There are not enough players to continue")
    end
end
 
table.foreach(tfm.get.room.playerList, eventNewPlayer)
 
