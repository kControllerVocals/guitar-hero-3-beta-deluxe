GH3_Download_Songs = {
	prefix = 'download'
	num_tiers = 1
	tier1 = {
		title = "Downloaded songs"
		songs = [
		]
		defaultunlocked = 4
		level = load_z_artdeco
	}
}

script scan_globaltag_downloads 
	printstruct ($GH3_Download_Songs)
	setup_setlisttags \{SetList_Songs = GH3_Download_Songs}
	setup_songtags
	setup_generalvenuetags
endscript
global_content_index_pak = 'none'

script Downloads_EnumContent 
	if EnumContentFiles download dofiles
		begin
		if EnumContentFilesFinished
			break
		else
			Wait 1 gameframe
		endif
		repeat
	endif
	if GetLatestContentIndexFile
		print "Found latest content index file:"
		printstruct <...>
		Downloads_OpenContentFolder content_index = <content_index>
		EnableDuplicateSymbolWarning off
		LoadPak <filename> device = <device> content_index = <content_index> heap = heap_downloads
		change global_content_index_pak = <filename>
		EnableDuplicateSymbolWarning
		Downloads_CloseContentFolder content_index = <content_index>
	else
		print "Found no latest content index file"
	endif
	GetContentFolderIndexFromFile 'z_download_dive.pak'
	printf "GetContentFolderIndexFromFile"
	printstruct <...>
	if ScriptExists Downloads_Startup
		Downloads_Startup
	endif
	Downloads_PostEnumContent
endscript

script Downloads_PostEnumContent 
	Download_RecreateZones
	scan_globaltag_downloads
endscript

script Downloads_UnloadContent 
	if NOT ($global_content_index_pak = 'none')
		UnloadPak ($global_content_index_pak)
		change \{global_content_index_pak = 'none'}
	endif
endscript

script Download_RecreateZones 
	printf \{"Loading Zone"}
	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	DestroyPakManMap \{map = zones}
	MemPushContext \{heap_zones}
	CreatePakManMap \{map = zones
		links = GH3Zones
		folder = 'zones/'
		uselinkslots}
	MemPopContext
	SetPakManCurrentBlock \{map = zones
		pak = z_soundcheck
		block_scripts = 1}
endscript
downloadcontentfolder_lock = 0

script Downloads_OpenContentFolder 
	begin
	if ($downloadcontentfolder_lock = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	change \{downloadcontentfolder_lock = 1}
	OpenContentFolder content_index = <content_index>
	begin
	GetContentFolderState
	if (<contentfolderstate> = opened)
		break
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script Downloads_CloseContentFolder 
	CloseContentFolder content_index = <content_index>
	begin
	GetContentFolderState
	if (<contentfolderstate> = free)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	change \{downloadcontentfolder_lock = 0}
endscript

script create_download_scan_menu 
	if ($downloadcontent_enabled = 0)
		ui_flow_manager_respond_to_action action = continue
		return
	endif
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu {
			textblock = {
				text = "Checking the HDD. Do not switch off your console."
			}
		}
		case xenon
		create_popup_warning_menu {
			textblock = {
				text = "Checking for downloadable content. Please don't turn off your Xbox 360 console."
			}
		}
	endswitch
	Downloads_EnumContent
	ui_flow_manager_respond_to_action action = continue
endscript

script destroy_download_scan_menu 
	destroy_popup_warning_menu
endscript

script is_musician_profile_downloaded 
	GetArraySize \{$Musician_Profiles}
	if (<index> < <array_size>)
		return \{download = 0
			true}
	else
		profile_struct = ($download_musician_profiles [(<index> - <array_size>)])
		get_pak_filename desc_id = (<profile_struct>.musician_body.desc_id) type = Body
		GetContentFolderIndexFromFile <pak_name>
		if (<device> = content)
			return \{download = 1
				true}
		else
			return \{download = 1
				false}
		endif
	endif
endscript

script is_musician_instrument_downloaded 
	GetArraySize \{$musician_instrument}
	if (<index> < <array_size>)
		return \{download = 0
			true}
	else
		profile_struct = ($download_musician_instrument [(<index> - <array_size>)])
		get_pak_filename desc_id = (<profile_struct>.desc_id) type = instrument
		GetContentFolderIndexFromFile <pak_name>
		if (<device> = content)
			return \{download = 1
				true}
		else
			return \{download = 1
				false}
		endif
	endif
endscript

script find_instrument_index 
	get_musician_instrument_size
	index = 0
	begin
	get_musician_instrument_struct index = <index>
	if (<info_struct>.desc_id = <desc_id>)
		return index = <index> true
	endif
	index = (<index> + 1)
	repeat <array_size>
	return \{false}
endscript

script store_select_downloads 
	NetSessionFunc \{func = ShowMarketPlaceUI}
	wait_for_blade_complete
	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	destroy_band
	Downloads_UnloadContent
endscript
