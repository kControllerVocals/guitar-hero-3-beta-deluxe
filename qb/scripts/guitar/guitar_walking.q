
script turn_to_face pos = (0.0, 0.0, 0.0)
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	walking_set = (<anim_set>.walking)
	turn_left = (<walking_set>.turn_left)
	turn_idle = (<walking_set>.turn_idle)
	turn_right = (<walking_set>.turn_right)
	min_turn = (<walking_set>.min_turn)
	max_turn = (<walking_set>.max_turn)
	target = <pos>
	if (<turn_left> = none || <turn_right> = none)
		get_angle_to_target target = <target>
		Angle = (<Angle> * -1)
		Obj_RotY Angle = <Angle> Speed = (<anim_set>.walking.turn_speed)
		return
	endif
	get_angle_to_target target = <pos>
	if (<Angle> < 0)
		turning_left = true
		0x64cbeb46 = (<Angle> * -1)
	else
		turning_left = false
		0x64cbeb46 = <Angle>
	endif
	begin
	if (<0x64cbeb46> < <min_turn>)
		break
	endif
	if (<0x64cbeb46> < <max_turn>)
		0x7cfa775b = (<0x64cbeb46>)
	else
		0x7cfa775b = <max_turn>
	endif
	play_turn_anim <...> Angle = <0x7cfa775b> turning_left = <turning_left>
	hero_wait_until_anim_finished
	0x64cbeb46 = (<0x64cbeb46> - <max_turn>)
	repeat
	get_angle_to_target target = <target>
	Angle = (<Angle> * -1)
	Obj_RotY Angle = <Angle> Speed = (<anim_set>.walking.turn_speed)
endscript

script play_turn_anim 
	blend = (<Angle> / <max_turn>)
	if (<blend> < 0)
		blend = 0
	elseif (<blend> > 1.0)
		blend = 1.0
	endif
	printf "playing turn with %a, %b, and %c............." a = <turn_idle> b = <turn_left> c = <turn_right>
	if (<turning_left> = true)
		hero_play_turn_anim Idleanim = <turn_idle> turnAnim = <turn_left> turnBlend = <blend>
	else
		hero_play_turn_anim Idleanim = <turn_idle> turnAnim = <turn_right> turnBlend = <blend>
	endif
endscript

script walk_to_waypoint rotate = true
	if GotParam index
		get_waypoint_id index = <index>
	elseif GotParam node
		GetPakManCurrent map = zones
		GetPakManCurrentName map = zones
		FormatText TextName = suffix '_TRG_Waypoint_%a' a = <node>
		AppendSuffixToChecksum Base = <pak> SuffixString = <suffix>
		waypoint_id = <appended_id>
	else
		printf "node not specified in walk_to_waypoint!"
		return
	endif
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if DoesWayPointExist name = <waypoint_id>
		change structurename = <info_struct> target_node = <waypoint_id>
		GetWaypointPos name = <waypoint_id>
		walk_to_pos dest = <pos>
		face_audience
	else
		printf "waypoint not found............"
	endif
endscript

script walk_to_pos walkspeed = 2 rotate = true backward = false
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	Obj_GetPosition
	world_pos_dest = (<dest>)
	offset = (<world_pos_dest> - <pos>)
	VectorLength vector = <offset>
	printf "dist to target is %a..........." a = <length>
	if (<length> < $min_walk_dist)
		return
	endif
	get_angle_to_target target = <dest>
	min_turn = (<anim_set>.walking.min_turn)
	if ((<Angle> > (-180 + <min_turn>) && <Angle> < (0.0 - <min_turn>)) || (<Angle> > <min_turn> && <Angle> < (180 - <min_turn>)))
		if (<rotate> = true)
			turn_to_face pos = <world_pos_dest>
		endif
	else
		if (<Angle> <= -90)
			Angle = (<Angle> + 180)
		elseif (<Angle> >= 90)
			Angle = (<Angle> - 180)
		endif
		Angle = (<Angle> * -1)
		Obj_RotY Angle = <Angle> Speed = (<anim_set>.walking.turn_speed)
	endif
	if IsFacing pos = <dest>
		walking_set = (<anim_set>.walking.forward)
	else
		walking_set = (<anim_set>.walking.backward)
	endif
	delta = (<pos> - <world_pos_dest>)
	x = (<delta>.(1.0, 0.0, 0.0))
	z = (<delta>.(0.0, 0.0, 1.0))
	delta = (<x> * (1.0, 0.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	VectorLength vector = <delta>
	if (<length> = 0.1)
		printf "not going anywhere?.........."
		return
	endif
	time = (<length> / <walkspeed>)
	desired_dist = (<length>)
	0x04724821
	SetSearchAllAssetContexts
	Anim_GetTotalDisplacement Anim = (<walking_set>.stop_left_anim.<anim_speed>)
	desired_dist = (<desired_dist> - <displacement>)
	anim_Getanimlength Anim = (<walking_set>.cycle_anim.<anim_speed>)
	Anim_GetTotalDisplacement Anim = (<walking_set>.cycle_anim.<anim_speed>)
	SetSearchAllAssetContexts off
	if (<displacement> = 0.0)
		cycles_needed = 3
	else
		cycles_needed = (<desired_dist> / <displacement>)
	endif
	precision_mode = false
	if (<precision_mode> = false)
		cycles_needed_float = (<cycles_needed>)
		CastToInteger cycles_needed
		fraction = (<cycles_needed_float> - <cycles_needed>)
		if (<fraction> > 0.5)
			cycles_needed = (<cycles_needed> + 1)
		endif
	endif
	time_needed = (<cycles_needed> * <length>)
	printf "starting to walk........."
	hero_play_anim Anim = (<walking_set>.start_anim.<anim_speed>)
	hero_wait_until_anim_finished
	printf "playing cycle......"
	if (<time_needed> > 0)
		hero_play_anim Anim = (<walking_set>.cycle_anim.<anim_speed>) BlendDuration = 0.0 Cycle
		Wait <time_needed> seconds
	endif
	0xc1abed5b
	printf "playing stop......"
	get_angle_to_target target = (0.0, 0.0, 50.0)
	if (<Angle> < <min_turn> && <Angle> > (0.0 - <min_turn>))
		Angle = (<Angle> * -1)
		Obj_RotY Angle = <Angle> Speed = (<anim_set>.walking.face_audience_speed)
	endif
	if (<foot> = left)
		hero_play_anim Anim = (<walking_set>.stop_left_anim.<anim_speed>)
	else
		hero_play_anim Anim = (<walking_set>.stop_right_anim.<anim_speed>)
	endif
	hero_wait_until_anim_finished
	printf "all done!................."
endscript

script 0xc1abed5b 
	if Anim_AnimNodeExists \{id = BodyTimer}
		Anim_Command \{target = BodyTimer
			command = Timer_GetFrameFactor}
		if (<framefactor> > 0.120000005 && <framefactor> < 0.62)
			return \{foot = left}
		else
			return \{foot = right}
		endif
	endif
endscript

script face_audience 
	turn_to_face \{pos = (0.0, 0.0, 50.0)}
endscript

script IsFacing 
	Obj_GetMatrix
	x = (<at>.(1.0, 0.0, 0.0))
	z = (<at>.(0.0, 0.0, 1.0))
	at = (<x> * (1.0, 0.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	dest_pos = <pos>
	Obj_GetPosition
	delta = (<dest_pos> - <pos>)
	x = (<delta>.(1.0, 0.0, 0.0))
	z = (<delta>.(0.0, 0.0, 1.0))
	delta = (<x> * (1.0, 0.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	if (<at>.<delta> < 0)
		return false
	else
		return true
	endif
endscript

script get_angle_to_target 
	Obj_GetPosition
	Obj_GetMatrix
	vec_to_pos = (<target> - <pos>)
	GetAngle vec1 = <at> vec2 = <vec_to_pos> rot_axis = y
	crossprod = (<vec_to_pos>.<left>)
	if (<crossprod> > 0.0)
		<Angle> = (0.0 - <Angle>)
	endif
	return {Angle = <Angle>}
endscript
