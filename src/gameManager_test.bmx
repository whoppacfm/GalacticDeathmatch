include "TGameManager.bmx"



Type TMyState Extends TGameState

   Field x:Float, y:Float

   Method Start()
      x = 10.0
      y = 200.0
   End Method
   
   Method Process()
      If KeyHit(KEY_ESCAPE) Then
         GameManager.NewGameState(Null)
         Return
      EndIf
      
      If KeyHit(KEY_SPACE) Then
	  	 'pausestate = self
		 GameManager.PauseAndNew(New TMyOtherState)
         'GameManager.SetGameState(New TMyOtherState)
         Return
      EndIf
   
      x  :+ GameManager.FPS_Val(200.0)
	  if x > 1000 then x = 0
	  
      Draw()
   End Method
   
   Method Leave()
   End Method
   
   Method Draw()
      DrawText GameManager.FPS(), 10, 300
      DrawRect x, y, 10, 10
   End Method

End Type




Type TMyOtherState Extends TGameState
	method start()
	End Method
	


   Method Enter()
   End Method
   
   Method Process()
   
      If KeyHit(KEY_ESCAPE) Then
         GameManager.NewGameState(Null)
         Return
      EndIf
   
      If KeyHit(KEY_SPACE) Then
         'GameManager.SetGameState(New TMyState)
		 'GameManager.SetGameState(pauseState)
		 GameManager.GoToPausedAndKill()
         Return
      EndIf
      
      Draw()
   End Method
   
   Method Leave()
   End Method
   
   Method Draw()
      DrawText "Der andere Gamestate", 10, 10
   End Method
   
End Type


'**** HAUPTTEIL ****
'Graphics 1024,768,32,-1
Graphics 1024,768,32,10


GameManager.InitGameManager(New TMyState)

EndGraphics
FlushMem
End

