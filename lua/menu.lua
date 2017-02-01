local Net = _G.LuaNetworking

function mute(id)
	if peer:is_muted() then --esta mutado
		peer:set_muted(false) --desmuta
		managers.chat:_receive_message(1, "Fast Mute", Net:GetNameFromPeerID(id) .. " was unmuted.", Color.red)
	else --nao esta mutado
		peer:set_muted(true) --muta
		managers.chat:_receive_message(1, "Fast Mute", Net:GetNameFromPeerID(id) .. " is mutated.", Color.green)
	end
end

if Net:IsMultiplayer() and Net:IsInHeist() then
	if Net:GetNumberOfPeers() > 0 then
		local peer = managers.network._session:peer(id)
		local menu_options = {}
		for _, peer in pairs(managers.network:session():peers()) do
			menu_options[#menu_options+1] ={text = peer:name(), data = peer:id(), callback = mute}
		end
		menu_options[#menu_options+1] = {text = "", is_cancel_button = true}
		menu_options[#menu_options+1] = {text = "Close", is_cancel_button = true}
		local muteMenu = QuickMenu:new("Fast Mute", "I want to mute...", menu_options)
		muteMenu:Show()
	else
		managers.chat:_receive_message(1, "FastMute", "You are alone in the game.", Color.red)
	end	
end
