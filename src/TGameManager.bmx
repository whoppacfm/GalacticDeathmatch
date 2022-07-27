'Strict

Rem 
Module pub.GameManager

ModuleInfo "Name:"
ModuleInfo "Version:"
ModuleInfo "Author:"

Import brl.system
Import brl.glmax2d
end rem 

'Basisklasse für Gamestates
Type TGameState Abstract

   'Starten des Gamestates (laden etc.)
   Method Start()
   End Method
   
   'Gamestate (wieder)aufrufen
   Method Enter(status:Int)
   End Method
      
   'Hauptschleife des Gamestates
   Method Process()
   End Method
   
   'Beenden des Gamestates (resourcen freigeben etc.)
   Method Leave()
   End Method
   
   'Zeichnen des Gamestates (kann in Process() aufgerufen werden)
   Method Draw()
   End Method

End Type



'FPS Manager - für frameunabhängiges Programmieren
Type TFPSManager

   Field _fps
   Field _fps_counter
   Field _fps_timer
   Field _fps_value:Float
   Field _fps_begin
   
   Method New()
      _fps_begin = MilliSecs()
   End Method
   
   'Aktualisiert die FPS Daten
   Method Update()
      Local ms = MilliSecs()
   
      _fps_value = (ms - _fps_begin) / 1000.0
      _fps_begin = ms

      If ms >= _fps_timer
         _fps = _fps_counter * 5
         _fps_counter = 0
         _fps_timer = ms + 200 '1/5 einer Sekunde
      Else
         _fps_counter :+ 1
      EndIf
   End Method
   
   'Gibt die aktuellen FPS zurück
   Method FPS()
      Return _fps
   End Method
   
   'Multipliziert den FPS Faktor mit einer Geschwindigkeit in pixel/sek. und gibt das Ergebnis zurück.
   Method FPS_Val:Float(Value:Float)
      Return _fps_value * Value
   End Method

End Type




'Gamemanager
Type TGameManager

   Field _state:TGameState               'aktueller Gamestate der ausgeführt wird.
   Field _quit:Byte                        'gibt an ob das Spiel beendet ist.
   Field _fps:TFPSManager               'frameunabhängiges Programmieren und FPS
   Field pauseState:TGameState
   

	'Start des Spiels mit übergabe einer GameState Instanz
   Method InitGameManager(state:TGameState = Null)
      If state = Null
        ' _state = New TMainGameState
      Else
         _state = state
      EndIf
      
	  _state.Start()
      _state.Enter(0)
      _quit = False
      _fps = New TFPSManager    
 
	  Run()   
   	
   End Method
   
   
   
   Method Run()
   
      'Hauptschleife des Spiels   
      While Not _quit
         _fps.Update()
         Cls
         Update()
         Flip
         'FlushMem
      Wend
      
      Terminate()
   End Method


   'Führt den aktuellen GameState aus, wenn keiner vorhanden wird _quit auf True gesetzt.   
   Method Update()
      If _state
         _state.Process()
      Else
         _quit = True
      EndIf
   End Method
   
   
   'Gibt vom aktuellen Gamestate verwendete Resourcen frei und setzt den Gamestate auf Null.
   Method Terminate()
      If _state
         _state.Leave()
         _state = Null
      EndIf
   End Method
          
   
   'Ändert den Gamestate. Auch Null möglich (wodurch das Spiel beendet wird).
   'Aktueller Gamestate geht verloren
	'Pausierter geht verloren
	
	
	'ACHTUNG: Aktuellen State immer in pause-state speichern
	'			letzte Methode wird voll durchlaufen
	'			-> daher muss er solange noch existieren !!!!
	' TODO: Testen obs auch klappt wenn ich dazu
	' 			ne lokale variable zum speichern nehme
	'			oder ne andere einführe außer pauseState !!!
	
	
	
   Method NewGameState(NewState:TGameState,status:Int)
      'DebugStop
      pausestate=Null
	  'FlushMem()
	
      If _state
         _state.Leave()
      EndIf
      
	  pausestate=_state
	  _state = NewState
	  
	  If newstate=Null Then _quit=True  
	
	  If _state Then
		  _state.Start()
	      _state.Enter(status)
	  End If     
	  'FlushMem()
   End Method
        
   
   'Aktuellen Gamestate pausieren und neuen starten
   Method PauseAndNew(NewState:TGameState,status:Int)
   		pauseState=Null
   		'FlushMem()      
      
      pauseState = _state
   	  _state = NewState

      If _state Then
	  	 _state.Start()
         _state.Enter(status)
      EndIf
   End Method
   
   'gibt pausierten Gamestate frei         
   Method killPaused()
   	  pauseState.Leave()
   	  pauseState=Null
   	  'FlushMem()
   End Method
   
   'setzt aktuellen Gamestate in den Pausemodus und führt den State in der Pause aus
   Method GoToPausedAndSave()
   	  Local tempstate:TGameState = _state
	  _state = pauseState
	  pauseState = tempstate
   	  tempstate = Null
	  pauseState.Enter(0)
   End Method
   
   'Wechselt zum pausierten Gamestate und lässt den aktuellen verschwinden
   Method GoToPausedAndKill()
   	   _state.Leave()
   	   _state = pauseState 
   	   pauseState=Null
   	   'FlushMem()
	   _state.Enter(0)
   End Method
     
   
   'Gibt die aktuellen FPS zurück
   Method FPS()
      Return _fps.FPS()
   End Method
   
   
   'Multipliziert den FPS Faktor mit einem Wert, wird für die frameunabhängige Programmierung benötigt.
   Method FPS_Val:Float(Value:Float)
      Return _fps.FPS_Val(Value)
   End Method
   
End Type





