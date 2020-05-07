ni.bootstrap = {
	rotation = function(profile, queue, abilities, data)
		data = true and data or {}
		ni.debug.log("Loaded " .. profile)
		rawset(ni.rotation.profile, profile, ni.bootstrap.start(queue, abilities, data))
	end,
	start = function(queue, abilities, data)
		return {
			loaded = false,
			execute = function()
				if not ni.rotation.profile[ni.vars.profiles.active].loaded then
					if data ~= nil and #data > 0 then
						if ni.utils.loaddatafiles(data) then
							ni.rotation.profile[ni.vars.profiles.active].loaded = true
						end
					else
						ni.rotation.profile[ni.vars.profiles.active].loaded = true
					end
				end

				if type(queue) == "function" then
					queue = queue()
				end
				for i = 1, #queue do
					local abilityinqueue = queue[i]
					if abilities[abilityinqueue]() then
						break
					end
				end
			end,
			unload = function()
				if ni.rotation.profile[ni.vars.profiles.active].loaded then
					table.wipe(ni.data)
					ni.rotation.profile[ni.vars.profiles.active].loaded = false
				end
			end
		}
	end
}
