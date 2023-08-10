Utils.Target = {}

function Utils.Target.createTargetInCoords(location_id,x,y,z,onSelectTargetOptionCallback,labelText,icon,iconColor,zone_id)
	if Config.custom_scripts_compatibility.target == 'ox_target' then
		exports['ox_target']:addSphereZone({
			coords = vector3(x,y,z),
			radius = 2.0,
			debug = false,
			options = {
				{
					icon = icon,
					iconColor = iconColor,
					label = labelText,
					distance = 2.5,
					onSelect = function()
						onSelectTargetOptionCallback(location_id)
					end,
				}
			}
		})
	elseif Config.custom_scripts_compatibility.target == 'qb-target' then
		assert(Config.framework ~= "ESX", "qb-target not available for ESX")
		local caller_resource = GetInvokingResource()
		zone_id = caller_resource .. ":" .. (zone_id or location_id)
		exports['qb-target']:AddBoxZone(zone_id, vector3(x,y,z), 2.5, 2.5, {
			name = zone_id,
			debugPoly = false,
			heading = 0.0,
			minZ = z - 2,
			maxZ = z + 2,
		}, {
			options = {
				{
					action = function()
						onSelectTargetOptionCallback(location_id)
					end,
					icon = icon,
					label = labelText
				}
			},
			distance = 2.5
		})
	elseif  Config.custom_scripts_compatibility.target == 'other' then
		-- Put here your own target export
	end
end