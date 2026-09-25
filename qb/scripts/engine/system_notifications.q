paused_for_hardware = 0
sysnotify_wait_in_progress = 0
xenon_device_checked = -1
sysnotify_game_already_paused = 0
sysnotify_paused_screen_elements = [
	current_menu_anchor
	signout_warning
	dialog_box_anchor
	link_lost_dialog_anchor
	quit_dialog_anchor
	keyboard_anchor
	controller_unplugged_dialog_anchor
]

script sysnotify_wait_until_safe 
	begin
	<should_wait> = 0
	if SystemUIDelayed
		<should_wait> = 1
		printf "WAITING FOR SYSTEM UI"
	endif
	if IsTrue $is_changing_levels
		<should_wait> = 1
		printf "WAITING FOR ISCHANGINGLEVELS"
	endif
	if IsTrue $igc_playing
		<should_wait> = 1
		printf "WAITING FOR IGC"
	endif
	if NOT CutsceneFinished name = cutscene
		<should_wait> = 1
		printf "WAITING FOR CUTSCENE"
	endif
	if ($ui_pro_success_screen_active = 0)
		if ScreenElementExists id = screenfader
			<should_wait> = 1
			printf "WAITING FOR SCREENFADER"
		endif
	endif
	if (<should_wait> = 1)
		change sysnotify_wait_in_progress = 1
		Wait 0.1 seconds
	else
		change sysnotify_wait_in_progress = 0
		return
	endif
	repeat
endscript

script 0x293a92ad 
	if NOT ScreenElementExists id = 0xb01a808e
		CreateScreenElement {
			type = TextElement
			parent = root_window
			id = 0xb01a808e
			font = text_a10
			pos = (640.0, 32.0)
			just = [center top]
			scale = 1.0
			rgba = [210 210 210 250]
			text = "Disk Ejected! Please Re-Insert!"
			z_priority = 5.0
			alpha = 1
		}
	endif
	sysnotify_handle_pause <...> seek_on_unpause
endscript

script sysnotify_handle_pause 
	printf "----------------------"
	printf "sysnotify_handle_pause"
	printf "----------------------"
	if ($paused_for_hardware = 1)
		return
	endif
	change paused_for_hardware = 1
	change sysnotify_game_already_paused = 1
	sysnotify_wait_until_safe
	if GameIsPaused
		printf "Game is already paused"
		return
	endif
	change sysnotify_game_already_paused = 0
	if NOT GotParam seek_on_unpause
		fade_overlay_on
	endif
	gh3_start_pressed <...>
endscript

script 0xade9482b 
	if ScreenElementExists \{id = 0xb01a808e}
		DestroyScreenElement \{id = 0xb01a808e}
	endif
	sysnotify_handle_unpause <...> seek_on_unpause
endscript

script sysnotify_handle_unpause 
	printf "------------------------"
	printf "sysnotify_handle_unpause"
	printf "------------------------"
	change paused_for_hardware = 0
	change wait_for_sysnotify_unpause_flag = 1
	sysnotify_wait_until_safe
	if NOT GameIsPaused
		return
	endif
	if NOT GotParam seek_on_unpause
		fade_overlay_off
	endif
	if ($sysnotify_game_already_paused = 0)
		if NOT ($playing_song = 1 && $is_attract_mode = 0)
			gh3_start_pressed <...>
		endif
	endif
	change sysnotify_game_already_paused = 0
endscript

script fade_overlay_on 
	if IsPs3
		if NOT ScreenElementExists \{id = pause_fader}
			CreateScreenElement \{type = SpriteElement
				id = pause_fader
				parent = root_window
				texture = black
				rgba = [
					0
					0
					0
					255
				]
				pos = (640.0, 360.0)
				dims = (1280.0, 720.0)
				just = [
					center
					center
				]
				z_priority = 9000
				alpha = 0.9}
		endif
	endif
endscript

script fade_overlay_off 
	if IsPs3
		if ScreenElementExists \{id = pause_fader}
			DestroyScreenElement \{id = pause_fader}
		endif
	endif
endscript
wait_for_sysnotify_unpause_flag = 0

script wait_for_sysnotify_unpause 
	change \{wait_for_sysnotify_unpause_flag = 0}
	printf \{"Waiting for sysnotify Pause Off"}
	begin
	printf "Waiting for sysnotify paused_for_hardware = %i" i = ($paused_for_hardware)
	if ($wait_for_sysnotify_unpause_flag = 1)
		break
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script sysnotify_reset_user_progress 
	reset_gamemode
	change \{attempted_xbox_autoload = 0}
	change \{no_load = 0}
	change \{xenon_device_checked = -1}
	change \{ui_cas_skater_selected = 0}
endscript
signin_change_happening = 0

script sysnotify_handle_signin_change 
	printf "------------------------------"
	printf "sysnotify_handle_signin_change"
	printf "------------------------------"
	if ($signin_change_happening = 1)
		printf "ALREADY BEING PROCESSED"
		return
	endif
	change signin_change_happening = 1
	sysnotify_wait_until_safe
	if ($ui_x360_sign_in_checked = 1)
		change ui_x360_sign_in_checked = 0
		change signin_change_happening = 0
		return
	endif
	switch <message>
		case live_connection_lost
		if InFrontend
			if NOT 0x4f3bfff1
				change signin_change_happening = 0
				return
			endif
		else
			if NOT InNetGame
				change signin_change_happening = 0
				return
			endif
		endif
		case live_connection_gained
		if NOT InFrontend
			if NOT InNetGame
				xenon_singleplayer_session_init
				change signin_change_happening = 0
				return
			endif
		else
			change signin_change_happening = 0
			return
		endif
		case user_changed
		printf "sysnotify_handle_signin_change - user changed"
		if ($respond_to_signin_changed = 1)
			handle_signin_changed
		endif
		default
		printf "- no response required"
		change signin_change_happening = 0
		return
	endswitch
	change signin_change_happening = 0
endscript
sysnotify_allow_invite = 1

script sysnotify_handle_game_invite 
	printf \{"----------------------------"}
	printf \{"sysnotify_handle_game_invite"}
	printf \{"----------------------------"}
	sysnotify_invite_go <...>
endscript

script sysnotify_invite_cancel 
	sysnotify_handle_unpause
	dialog_box_exit
endscript

script sysnotify_invite_go 
	printf \{"----sysnotify_invite_go"}
	if GotParam \{cross_game}
		cross_game_invite_accepted <...>
	else
		sysnotify_wait_until_safe
		invite_accepted <...>
	endif
endscript

script sysnotify_handle_connection_loss 
	printf \{"--------------------------------"}
	printf \{"sysnotify_handle_connection_loss"}
	printf \{"--------------------------------"}
	sysnotify_wait_until_safe
	cleanup_sessionfuncs
	xboxlive_lost_connection_ui_cleanup
	create_link_unplugged_dialog
endscript

script sysnotify_cleanup_misc 
	if ScreenElementExists id = root_window
		LaunchEvent type = unfocus target = root_window
	endif
	sysnotify_cleanup_ui
	if InFrontend
		KillSpawnedScript name = attract_mode_timer
		if ScreenElementExists id = cas_category_anchor
			DestroyScreenElement id = cas_category_anchor
		endif
		if ScreenElementExists id = progress_anchor
			DestroyScreenElement id = progress_anchor
		endif
	endif
	destroy_onscreen_keyboard
	if InNetGame
		force_close_rankings dont_retry
		if LocalSkaterExists
			skater :Vibrate off
		endif
		if NOT IsObserving
			ExitSurveyorMode
		endif
		dialog_box_exit anchor_id = link_lost_dialog_anchor
		dialog_box_exit anchor_id = quit_dialog_anchor
	endif
	if ScreenElementExists id = piece_menu_hmenu
		DestroyScreenElement id = piece_menu_hmenu
	endif
	dialog_box_exit
	change main_menu_return_to_createamodes = 0
	change check_for_unplugged_controllers = 0
	change inside_pause = 0
	kill_start_key_binding
	KillSpawnedScript name = main_menu_exit
	GetCurrentLevel
	if (<level> = load_z_bedroom)
		if ViewportExists id = z_bedroom_select_viewport
			z_bedroom_kill_select_bink
		endif
		z_bedroom_exit_unload
	endif
endscript

script sysnotify_cleanup_ui 
	printf "--------------------------------"
	printf "sysnotify_cleanup_ui"
	printf "--------------------------------"
	KillSpawnedScript name = ui_mainmovies_wait_for_movie
	KillSpawnedScript name = ui_initial_interactive_screen
	KillSpawnedScript name = ui_attract_wait_for_movie
	KillSpawnedScript name = ui_mainmenu_wait_for_movie
	KillSpawnedScript name = attract_timer_wait
	KillSpawnedScript name = goal_classic_mode_post_cams
	KillSpawnedScript name = goal_classic_mode_show_cams
	KillSkaterCamAnim name = goal_classic_mode_cam
	if ScreenElementExists id = ui_mainmovie_wait_anchor
		DestroyScreenElement id = ui_mainmovie_wait_anchor
	endif
	if IsMoviePlaying TextureSlot = 0
		KillMovie TextureSlot = 0
	endif
	if IsMoviePlaying TextureSlot = 1
		KillMovie TextureSlot = 1
	endif
	if ViewportExists id = z_mainmenu_bink_viewport
		PushAssetContext context = Z_Mainmenu
		DestroyViewportTextureOverride id = z_mainmenu_bink_viewport
		DestroyViewport id = z_mainmenu_bink_viewport
		PopAssetContext
	endif
	if ViewportExists id = thp8_shop_viewport
		PushAssetContext context = Z_Shops
		DestroyViewportTextureOverride id = thp8_shop_viewport
		DestroyViewport id = thp8_shop_viewport
		PopAssetContext
	endif
	change pause_fmv_playing = 0
	KillSpawnedScript name = xenon_handle_first_input
	if ScreenElementExists id = edit_tricks_menu_parts_anchor
		DestroyScreenElement id = edit_tricks_menu_parts_anchor
	endif
	if ScreenElementExists id = edit_tricks_sub_menu_anchor
		DestroyScreenElement id = edit_tricks_sub_menu_anchor
	endif
	if ScreenElementExists id = choose_trick_menu_container
		DestroyScreenElement id = choose_trick_menu_container
	endif
	if ScreenElementExists id = ui_mainmenu_wait_anchor
		DestroyScreenElement id = ui_mainmenu_wait_anchor
	endif
	if ScreenElementExists id = goal_presentation_anchor
		DestroyScreenElement id = goal_presentation_anchor
	endif
	if ScreenElementExists id = select_skater_anchor
		DestroyScreenElement id = select_skater_anchor
	endif
	KillSpawnedScript name = goal_create_pro_success_screen
	KillSpawnedScript name = goal_destroy_pro_success_screen
	KillSpawnedScript name = goal_generic_exit_menu_and_videos
	if ($ui_pro_success_screen_active = 1)
		if GMan_HasActiveGoals
			GMan_GetActivatedGoalId
			goal_destroy_pro_success_screen do_pause = 0 goal = <activated_goal_id> pass_pro_goal = 0
		endif
	endif
endscript
