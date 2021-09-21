AddEventHandler('QBCore:PlayerJoined',function()
local src = source
CreateThread(function()
Wait(5000)
local license,steamID,liveid,xblid,discord,playerip
local playername = GetPlayerName(src)

    	for k,v in ipairs(GetPlayerIdentifiers(src))do
    		if string.sub(v, 1, string.len("license:")) == "license:" then
    			license = v
    		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
    			steamID = v
    		elseif string.sub(v, 1, string.len("live:")) == "live:" then
    			liveid = v
    		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
    			xblid  = v
    		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
    			discord = v
    		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
    			playerip = v
    		end
    	end

    	MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
    		['@license'] = license
    	}, function(data)
    	local found = false
    		for i=1, #data, 1 do
    			if data[i].license == license then
    				found = true
    			end
    		end
    		if not found then
    			MySQL.Async.execute('INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername)',
    				{
    				['@license']    = license,
    				['@identifier'] = steamID,
    				['@liveid']     = liveid,
    				['@xblid']      = xblid,
    				['@discord']    = discord,
    				['@playerip']   = playerip,
    				['@playername'] = playername
    				},
    				function ()
    			end)
    		else
    			MySQL.Async.execute('UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername WHERE `license` = @license',
    				{
    				['@license']    = license,
    				['@identifier'] = steamID,
    				['@liveid']     = liveid,
    				['@xblid']      = xblid,
    				['@discord']    = discord,
    				['@playerip']   = playerip,
    				['@playername'] = playername
    				},
    				function ()
    			end)
    		end
    	end)
    end)

end)
