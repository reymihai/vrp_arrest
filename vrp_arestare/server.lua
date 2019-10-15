local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "vrp_Farmer") 
vRP = Proxy.getInterface("vRP")  


local choice_mitarrest = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
     TriggerClientEvent('mita:arrestonway', nplayer, source) 
     TriggerClientEvent('radu:arrest', source)  
     Citizen.Wait(5000)
     vRPclient.toggleHandcuff(nplayer,{})
    else
      vRPclient.notify(player,{"Nu e nimeni prin preajma boule"})
    end
  end)
end, "Aresteaza fraieru"}

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    if vRP.hasPermission({user_id,"police.askid"}) then
       choices["Mita Arrest"] = choice_mitarrest
    end
	
    add(choices)
  end
end})



