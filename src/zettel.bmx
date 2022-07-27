	'0 UpdateMainMenu()
	'1 UpdateOptionsMenu()   
	'2 updateGFXMenu()       
	'3 UpdatePauseMenu()  
	'4 UpdateSpielmodus()
	'5 UpdateLevelAuswahl()
	'6 UpdateSchiffAuswahl()
	
	
	Field MainMenu:TMenu   
	Field GFXMenu:TMenu
	Field PauseMenu:TMenu
	Field OptionsMenu:TMenu	
	
	Field ModusMenu:TMenu
	Field LevelMenu:TMenu
	Field ShipMenu:TMenu
	
	GameManager.PauseAndNew(New TPlayState,0)
	
ModusMenu.AddMenuItem(TMenuItem.Create("Training",200, 300,1,4,1, superfont, 255, 255, 255,2,1))
ModusMenu.AddMenuItem(TMenuItem.Create("Deathmatch",200, 350,1,4,1, superfont, 255,255, 255,3,1))
'ModusMenu.AddMenuItem(TMenuItem.Create("Don't Die",200, 400,1,4,1, superfont, 255,255, 255,4,1))
ModusMenu.setmiddle()
'ModusMenu.AddMenuItem(TMenuItem.Create("Mass Destruction",550, 300,1,4,1, superfont, 255,255, 255,5,1))
'ModusMenu.AddMenuItem(TMenuItem.Create("Capture the Flag",550, 350,1,4,1, superfont, 255,255, 255,6,1))
'ModusMenu.AddMenuItem(TMenuItem.Create("Army Master",550, 400,1,4,1, superfont, 255,255, 255,7,1))			
            