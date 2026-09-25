Drums_AutoNoteMapping = [
	{
		MidiNote = 70
		Scr = Countoff_NoteMap
		params = {
		}
	}
]
Crowd_AutoNoteMapping = [
	{
		MidiNote = 70
		Scr = NoteMap_Dummy
		params = {
		}
	}
]

script NoteMap_Dummy 
	printf \{"dummy"}
endscript

script Countoff_NoteMap 
	get_song_struct song = ($current_song)
	if StructureContains Structure = <song_struct> name = countoff
		countoff_sound = (<song_struct>.countoff)
	else
		countoff_sound = 'sticks_normal'
	endif
	if (<velocity> > 99)
		FormatText checksumname = sound_event_name 'Countoff_SFX_%s_Hard' s = <countoff_sound>
	else
		if (<velocity> > 74)
			FormatText checksumname = sound_event_name 'Countoff_SFX_%s_Med' s = <countoff_sound>
		else
			if (<velocity> > 49)
				FormatText checksumname = sound_event_name 'Countoff_SFX_%s_Soft' s = <countoff_sound>
			else
				FormatText checksumname = sound_event_name 'Countoff_SFX_%s_Soft' s = <countoff_sound>
			endif
		endif
	endif
	SoundEvent event = <sound_event_name>
endscript

script notemap_startiterator 
	FormatText checksumname = global_notemapping '%s_AutoNoteMapping' s = <event_string>
	if NOT GlobalExists name = <global_notemapping> type = array
		return
	endif
	FormatText checksumname = event_checksum '%s' s = <event_string>
	SetNoteMappings section = <event_checksum> mapping = $<global_notemapping>
	spawnscriptnow notemap_iterator params = {<...>}
endscript

script notemap_deinit 
	ClearNoteMappings \{section = all}
	KillSpawnedScript \{name = notemap_iterator}
endscript

script notemap_iterator 
	printf "Notemap Iterator started with time %d" d = <time_offset>
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_%e_notes' s = <song_prefix> e = <event_string> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		printf "No Drums Notes for Drums Iterator?"
		return
	endif
	array_entry = 0
	fretbar_count = 0
	GetArraySize $<event_array>
	event_array_size = <array_size>
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<event_array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>] [0])
			break
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <event_array_size>
		event_array_size = (<event_array_size> - <array_entry>)
		if NOT (<event_array_size> = 0)
			begin
			begin
			if (<time> >= $<event_array> [<array_entry>] [0])
				break
			endif
			Wait 1 gameframe
			GetSongTimeMs time_offset = <time_offset>
			repeat
			note = ($<event_array> [<array_entry>] [1])
			if GetNoteMapping section = <event_checksum> note = <note>
				GetArraySize ($<event_array> [<array_entry>])
				velocity = 100
				if (<array_size> > 3)
					velocity = ($<event_array> [<array_entry>] [3])
				endif
				spawnscriptnow (<note_data>.Scr) params = {(<note_data>.params) length = ($<event_array> [<array_entry>] [2]) velocity = <velocity>}
			endif
			<array_entry> = (<array_entry> + 1)
			repeat <event_array_size>
		endif
	endif
endscript
