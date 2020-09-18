-- Leader of draw script by Aron#6810
for _,modulo in next,{"disableAfkDeath","disableAutoNewGame","disableAutoScore","disableAutoShaman","disableAutoTimeLeft","disablePhysicalConsumables"} do
    tfm.exec[modulo](true)
end
admins = {["Aron#6810"] = true}
players = {}
banned = {}
subjects = {"زهرة","شمس","قمر","انسان","علبة","ماء","قارورة عصير","شاحنة","سيارة","مدرسة","كلب","قطة","قرد","فار","كوكب الارض","كرسي","باب","نافذة"}
tfm.exec.newGame("@7783037")
canAns = false
local drawer = 0
local sub =  0
function module()
    for name , player in next, tfm.get.room.playerList do
        table.insert(players,name)
    end
    tfm.exec.setUIMapName("<ch> يتم إختيار رسام ... </ch>")
end

drow = math.random(#players)
chose = 0
function eventLoop(past,left)
    chose = chose + 1
    if left < 1000 then
        tfm.exec.newGame("@7783037")
    end
    if chose == 20 then
        if not banned[players[drow]] then
            tfm.exec.setUIMapName("<ch>الرسام :</ch>".. " " .. players[drow])
        else
            tfm.exec.setUIMapName("<ch>الرسام : الرسام محظور</ch>")
            tfm.exec.setGameTime(0,true)
        end
        drower()
    end
end

drow = math.random(#players)
sub = math.random(#subjects)
function drower()
    if not banned[players[drow]] then
        tfm.exec.killPlayer(players[drow])
        tfm.exec.chatMessage("<vp> حان وقت تخمين الرسمة التي سيرسمها الرسام !!!")
        ui.addTextArea(0, "<p align='center'><font size='23'> الرسمة التي يجب عليك رسمها هي " .. " " .. subjects[sub] , players[drow], 7, 34, 788, 56, 0x0d171c, 0x000000, 1, true)
        ui.addTextArea(2, "<a href='event:clear'><p align='center'>C", players[drow], 11, 316, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        ui.addTextArea(1, "<a href='event:color'>                                                                 \n                                                                                          \n                                          ", players[drow], 9, 343, 40, 52,uicolor, 0xc9db00, 1, true)
        ui.addTextArea(3, "<a href='event:-'><p align='center'><b>-", players[drow], 11, 287, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        ui.addTextArea(4, "<a href='event:+'><p align='center'><b>+", players[drow], 11, 260, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        system.bindMouse(players[drow],true)
        canAns = true
    end
end

drow = math.random(#players)
function eventNewGame()
    system.bindMouse(players[drow],false)
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
end

sub = math.random(#subjects)

function eventChatMessage(name,message)
    if message == subjects[sub] then
        if players[name] and players[name].ban then
            players[name].ban = players[name].ban + 1
        end
        if players[name].ban == 1 then
            tfm.exec.chatMessage("<r> تحذير : لايمكنك مشاركة الأجوبة مع باقي الاشخاص (1/2)",name)
        end
        if players[name].ban == 2 then
            tfm.exec.chatMessage("<r> تحذير : لايمكنك مشاركة الأجوبة مع باقي الاشخاص (2/2) تم حظرك !",name)
            ui.addTextArea(1000000000000000000, "",name, -404, -137, 1576, 874, 0x040505, 0x000000, 1, true)
            banned[name] = true
        end
    end
end

id = 5
size1 = 14
size2 = 16
function eventMouse(name,x,y)
    id = id + 1
    ui.addTextArea(id, "", nil, x , y , size1, size2, uicolor, uicolor, 1, true)
end

function eventChatCommand(name,command)
    local args = {}
    for name in command:gmatch("%S+") do
        table.insert(args, name)
    end
    if admins[name] then
        if args[1] == "time" then
            tfm.exec.setGameTime(tonumber(args[2]),true)
        end
    end
    if command == "an" then
        if canAns == true then
            ui.addPopup(1,2,"<p align='center'> اكتب توقعك هنا :",name, 187, 121, 425, 202,true)
        else
            tfm.exec.chatMessage("<r> لايمكنك الإجابة الأن </r>",name)
        end
    end
end

function eventTextAreaCallback(id,name,callback)
    if callback ==  "color" then
        ui.showColorPicker(1,name,0,"إختر لون الرسام الخاص بك")
    elseif callback == "+" then
        size1 = size1 + 3
        size2 = size2 + 3
    elseif callback == "-" then
        size1 = size1 - 3
        size2 = size2 - 3
    elseif callback == "clear" then
        for id = 5,9999 do
            ui.removeTextArea(id,nil)
        end
        id = 5
    end
end

sub = math.random(#subjects)
function eventPopupAnswer(id, name, answer)
    if id == 1 then
        if answer == subjects[sub] then
            tfm.exec.chatMessage("<vp> لقد أجاب بشكل صحيح مبرووك ! "..name.."",nil)
            tfm.exec.giveCheese(name)
            tfm.exec.playerVictory(name)
        end
    end
end

function eventColorPicked(id, name, color)
    uicolor = color
    ui.addTextArea(1, "<a href='event:color'>                                                                 \n                                                                                          \n                                          ", players[drow], 9, 343, 40, 52,uicolor, 0xc9db00, 1, true)
end

function eventNewPlayer(name)
    players[name] = {ban = 0}
    tfm.exec.chatMessage("<vp> مرحبا بك في النمط ! \n سيختار النمط شخصا عشوائيا للرسم وعليك عند تخمين الرسمة \n كتابة الإيعاز التالي : !an \n وكتابة تخمينك \n تم صناعة النمط من قبل Aron#6810",name)
    if banned[name] then
        ui.addTextArea(1000000000000000000, "",name, -404, -137, 1576, 874, 0x040505, 0x000000, 1, true)
    end
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)
