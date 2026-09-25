
script Band_PlaysimpleAnim \{name = Guitarist}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if NOT GotParam \{Anim}
		return
	endif
	<name> :Obj_KillSpawnedScript name = play_simple_anim
	<name> :Obj_SpawnScriptNow play_simple_anim params = {Anim = <Anim>}
endscript

script Band_PlayAnim \{name = Guitarist
		Anim = Idle}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	LaunchEvent type = play_anim target = <name> data = {<...>}
endscript

script band_playidle \{name = Guitarist}
	Band_PlayAnim name = <name> Anim = Idle Cycle
endscript

script Band_PlayFacialAnim \{name = Guitarist}
	if CompositeObjectExists name = <name>
		<name> :Obj_KillSpawnedScript name = hero_play_facial_anim
		<name> :Obj_SpawnScriptNow hero_play_facial_anim params = {Anim = <Anim>}
	endif
endscript

script Band_SetStrumStyle \{name = Guitarist
		style = Long}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> strum = <style>
endscript

script Band_ChangeStance \{name = Guitarist
		stance = Stance_A}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	LaunchEvent type = change_stance target = <name> data = {<...>}
endscript

script Band_StopStrumming \{name = Guitarist}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> strum = none
endscript

script Band_EnableArms \{name = Guitarist
		blend_time = 0.25}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :hero_enable_arms blend_time = <blend_time>
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> arms_disabled = false
	change structurename = <info_struct> disable_arms = false
endscript

script Band_DisableArms \{name = Guitarist
		blend_time = 0.25}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :hero_disable_arms blend_time = <blend_time>
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> arms_disabled = true
	change structurename = <info_struct> disable_arms = true
endscript

script Band_SetPosition 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	char_name = <name>
	if GotParam index
		get_waypoint_id index = <index>
		GetWaypointPos name = <waypoint_id>
		change structurename = <info_struct> target_node = <waypoint_id>
	elseif GotParam node
		GetWaypointPos name = <node>
		change structurename = <info_struct> target_node = <node>
	endif
	<char_name> :Obj_SetPosition position = <pos>
endscript

script Band_DisableMovement 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> allow_movement = false
endscript

script Band_EnableMovement 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> allow_movement = true
endscript

script Band_WalkToNode \{name = Guitarist
		faceAudience = true}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if ($current_num_players = 2)
		return
	endif
	LaunchEvent type = walk target = <name> data = {<...> anim_set = $normal_walk_data}
endscript

script Band_TurnToFace \{name = Guitarist
		node = 1}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	get_waypoint_id index = <node>
	GetWaypointPos name = <waypoint_id>
	<name> :turn_to_face pos = <pos>
endscript

script Band_RotateToFaceNode \{name = Guitarist
		node = 1}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	get_waypoint_id index = <node>
	GetWaypointPos name = <waypoint_id>
	<name> :turn_to_face pos = <pos>
endscript

script Band_FaceNode \{name = Guitarist
		node = 1}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	get_waypoint_id index = <node>
	GetWaypointPos name = <waypoint_id>
	<name> :turn_to_face pos = <pos>
endscript

script Band_FaceAudience \{name = Guitarist}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :face_audience
endscript

script Band_PlayAttackAnim 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	attack_type = ($battlemode_powerups [<type>].name)
	if (($player1_status.band_member) = <name>)
		battle_anims = player1_battlemode_anims
	elseif (($player2_status.band_member) = <name>)
		battle_anims = player2_battlemode_anims
	else
		return
	endif
	if NOT StructureContains Structure = $<battle_anims> name = <attack_type>
		return
	endif
	Anim = ($<battle_anims>.<attack_type>.attack_anim)
	if NOT (<Anim> = none)
		LaunchEvent type = play_battle_anim target = <name> data = {<...> no_wait}
	endif
endscript

script Band_PlayResponseAnim 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	attack_type = ($battlemode_powerups [<type>].name)
	if (($player1_status.band_member) = <name>)
		battle_anims = player1_battlemode_anims
	elseif (($player2_status.band_member) = <name>)
		battle_anims = player2_battlemode_anims
	else
		return
	endif
	if NOT StructureContains Structure = $<battle_anims> name = <attack_type>
		return
	endif
	Anim = ($<battle_anims>.<attack_type>.response_anim)
	if NOT (<Anim> = none)
		LaunchEvent type = play_battle_anim target = <name> data = {<...>}
	endif
endscript
