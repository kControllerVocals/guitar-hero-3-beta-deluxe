script GuitarEvent_HitNote 
	SpawnScriptNow GuitarEvent_HitNote_Spawned Params = {<...>}
	if ($firework_gems = 1)
		SpawnScriptNow GuitarEvent_StarSequenceBonus Params = {<...> fireworks = 1}
	endif
endscript