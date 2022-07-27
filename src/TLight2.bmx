 ' Lighting Demo 
' NOTE - RIPED From WIP, so sorry for the map types etc...
' ============================================
' Created By Stefan J Lulham

' Const's
Const iTileWidth:Int = 17
Const iTileHeight:Int = 17

' Globals
Global iXOffset:Int = 0
Global iYOffset:Int = 0

Global iDMX:Int = 0
Global iDMY:Int = 0

' Map
' Info about a map
Type Map
	
	' Properties
	Field m_sName:String ' Name of the map
	Field m_iWidth:Int ' Width of the map
	Field m_iHeight:Int ' Height of the map
	
	' Special Properties
	Field m_kTile:Tile[0, 0]
	Field m_kAreaList:TList = CreateList()
	
	' Create a map
	Function Create:Map(sName:String, iWidth:Int, iHeight:Int)
		' Create a local map
		Local kMap:Map = New Map
		kMap.m_sName = sName
		kMap.m_iWidth = iWidth
		kMap.m_iHeight = iHeight
		kMap.m_kTile = New Tile[iWidth + 1, iHeight + 1]
		
		' Setup the map tiles
		For iX = 0 To iWidth
			For iY = 0 To iHeight
				kMap.m_kTile[iX, iY] = New Tile
				kMap.m_kTile[iX, iY].m_iFloor = 0
				kMap.m_kTile[iX, iY].m_iWall = -1
				kMap.m_kTile[iX, iY].m_iWallType = 0
				kMap.m_kTile[iX, iY].m_iDarkness = 255
				kMap.m_kTile[iX, iY].m_bWindow = False
				kMap.m_kTile[iX, iY].m_bDoor = False
				kMap.m_kTile[iX, iY].m_bDoorOpen = False
				kMap.m_kTile[iX, iY].m_bFoged = False
				kMap.m_kTile[iX, iY].m_bExplored = False
				kMap.m_kTile[iX, iY].m_bLit = 0
				
				kMap.m_kTile[iX, iY].m_iRed = 255
				kMap.m_kTile[iX, iY].m_iGreen = 255
				kMap.m_kTile[iX, iY].m_iBlue = 255
			Next
		Next
		
		Return kMap ' Return the local map
	End Function
	
	' Render the map
	Method Render()
		For iX = 0 To m_iWidth
			For iY = 0 To m_iHeight
				If m_kTile[iX, iY].m_bFoged = False Then
					' Set the colour for the tile based on the darkness
					iRed = m_kTile[iX, iY].m_iRed - m_kTile[iX, iY].m_iDarkness
					If iRed < 0 Then iRed = 0
					If iRed > 255 Then iRed = 255
					
					iGreen = m_kTile[iX, iY].m_iGreen - m_kTile[iX, iY].m_iDarkness
					If iGreen < 0 Then iGreen = 0
					If iGreen > 255 Then iGreen = 255
					
					iBlue = m_kTile[iX, iY].m_iBlue - m_kTile[iX, iY].m_iDarkness
					If iBlue < 0 Then iBlue = 0
					If iBlue > 255 Then iBlue = 255

					' Calculate the offset
					iXOffset = (GraphicsWidth() / 2) - (iDMX * 17)
					iYOffset = (GraphicsHeight() / 2) - (iDMY * 17)					
					
					SetColor iRed, iGreen, iBlue
					DrawRect (iX * iTileWidth) + (iXOffset), (iY * iTileWidth) + (iYOffset), 17, 17'DrawImage kFloorImg, (iX * iTileWidth) + (iXOffset), (iY * iTileWidth) + (iYOffset), m_iFloor
					SetColor 255, 255, 255	
				EndIf
			Next
		Next
	End Method
	
	' Update the map
	Method Update()
		For iX = 0 To m_iWidth
			For iY = 0 To m_iHeight
				m_kTile[iX, iY].m_bFoged = True
				m_kTile[iX, iY].m_iDarkness = 255
				m_kTile[iX, iY].m_bLit = 0
			Next
		Next
	End Method
	
	' Light an area of a map
	Method LightArea(iCenterX:Int, iCenterY:Int, iFactor:Int = 4, fIntesity:Float = .1, iRed = 255, iGreen = 255, iBlue = 255)
		'iFactor = 8
		For iAngle:Int = 1 To 360
			For k = 1 To 30
				iDarkness:Int = 255
				tempx = (iCenterX * iTileWidth) + k * iFactor * Cos(iAngle)
				tempy = (iCenterY * iTileHeight) + k * iFactor * Sin(iAngle)

				'If k * iFactor > (30*fIntesity*iFactor)  And k * iFactor <= (30 *iFactor) Then
					iDarkness = (Abs(((30-k)/(30-30*(fIntesity/2))) * 255)) 
				'EndIf
				'DrawText iDarkness, 10, 24 + (k * 12)
				iDarkness:-255
				iDarkness:* -1
						
				ttempx = tempx - tempx Mod iTileWidth
				ttempx = (ttempx / iTileWidth) + 1
				ttempy = tempy - tempy Mod iTileHeight
				ttempy = (ttempy / iTileHeight) + 1
				If ttempx >= 0 And ttempx <= m_iWidth And ttempy >= 0 And ttempy <= m_iHeight Then
					If	m_kTile[ttempx , ttempy].m_bLit = 0 Then
						' Darkness Adding
						m_kTile[ttempx, ttempy].m_iDarkness = (m_kTile[ttempx, ttempy].m_iDarkness + iDarkness) - 255
						If m_kTile[ttempx, ttempy].m_iDarkness < 0 Then m_kTile[ttempx, ttempy].m_iDarkness = 0
						If m_kTile[ttempx, ttempy].m_iDarkness > 255 Then m_kTile[ttempx, ttempy].m_iDarkness = 255
						
						' Colour Adding
						' - Red
						m_kTile[ttempx , ttempy].m_ired = ((m_kTile[ttempx , ttempy].m_ired + ired))
						If m_kTile[ttempx , ttempy].m_ired =< 0 Then m_kTile[ttempx , ttempy].m_ired = 0
						If m_kTile[ttempx , ttempy].m_ired => 255 Then m_kTile[ttempx , ttempy].m_ired = 255
						' - Green
						m_kTile[ttempx , ttempy].m_igreen = ((m_kTile[ttempx , ttempy].m_igreen + igreen))
						If m_kTile[ttempx , ttempy].m_igreen =< 0 Then m_kTile[ttempx , ttempy].m_igreen =0
						If m_kTile[ttempx , ttempy].m_igreen => 255 Then m_kTile[ttempx , ttempy].m_igreen = 255
						' - Blue
						m_kTile[ttempx , ttempy].m_iblue = ((m_kTile[ttempx , ttempy].m_iblue + iblue))
						If m_kTile[ttempx , ttempy].m_iblue=< 0 Then m_kTile[ttempx , ttempy].m_iblue= 0
						If m_kTile[ttempx , ttempy].m_iblue=> 255 Then m_kTile[ttempx , ttempy].m_iblue= 255
					
						' Tile has had manip done already
						m_kTile[ttempx , ttempy].m_bLit = 1
					EndIf
					'If map[ttempx , ttempy].iWindow = -1 Then
					'	If map[ttempx , ttempy].iWall > -1 Then
					'		map[ttempx , ttempy].bFoged = False
					'		map[ttempx, ttempy].bExplored = True
					'		Goto goto1	
					'	EndIf
					'EndIf
					
					m_kTile[ttempx , ttempy].m_iRed = iRed
					m_kTile[ttempx , ttempy].m_iGreen = iGreen
					m_kTile[ttempx , ttempy].m_iBlue = iBlue
					m_kTile[ttempx , ttempy].m_bFoged = False
					'map[ttempx, ttempy].bExplored = True
				Else
					Goto a001
				End If
			Next
			#a001
		Next
		
		For x = 0 To m_iWidth
			For y = 0 To m_iHeight
				m_kTile[x , y].m_bLit = False
			Next
		Next
	End Method
End Type

' Tile
' Holds info about a single map tile
Type Tile
	
	' Properties
	Field m_iFloor:Int ' Floor image frame used
	Field m_iWall:Int ' Wall image frame used (includes Windows, Doors)
	Field m_iWallType:Byte ' The kind of wall (Wooden, Brick, etc.) 
	Field m_iDarkness:Int ' The darkness of the tile
	
	' Flags
	Field m_bWindow:Byte ' Is it a window
	Field m_bDoor:Byte ' Is it a door
	Field m_bDoorOpen:Byte ' Is the door open
	Field m_bLit:Byte ' Has it been Lit
	Field m_bExplored:Byte ' Has it been explored
	Field m_bFoged:Byte ' Is it foged
	
	' Colour
	Field m_iRed:Byte ' Red part
	Field m_iGreen:Byte ' Geen part
	Field m_iBlue:Byte ' Blue part
	
End Type

' Area
' Holds info about any "area's"
Type Area
	
	' Properties
	Field m_sName:String ' Name of the area
	Field m_iX:Int ' X position
	Field m_iY:Int ' y position
	Field m_iWidth:Int ' Width of the area
	Field m_iHeight:Int ' Height of the area
	
	' Lighting properties
	Field m_iRed:Byte ' Red part
	Field m_iGreen:Byte ' Geen part
	Field m_iBlue:Byte ' Blue part
	Field m_iPower:Byte ' Power of the light
	
End Type

Graphics 640, 480, 32
SetMaskColor 255, 0, 255
SetBlend ALPHABLEND

'Global kFloorImg = LoadAnimImage("gfx/floor.bmp", iTileWidth, iTileHeight, 0, 1)

Global kCurrentMap:Map = Map.Create("Noob", 200, 200)

Intesity# = .1
Lightness = 10
While Not KeyHit(Key_Escape)
	
	Cls
	
	If KeyHit(Key_Up) Or MouseY() <= 3 Then iDMY:- 1
	If KeyHit(Key_Down) Or MouseY() >= GraphicsHeight() - 3 Then iDMY:+ 1
	If KeyHit(Key_Left) Or MouseX() <= 3 Then iDMX:- 1
	If KeyHit(Key_Right) Or MouseX() >= GraphicsWidth() - 3 Then iDMX:+ 1
	
	If KeyDown(Key_Q) Then Lightness:- 1
	If KeyDown(Key_W) Then Lightness:+ 1
	If Lightness > iTileWidth Then Lightness = iTileWidth
	If Lightness < 0 Then Lightness = 0
	
	If KeyDown(Key_A) Then Intesity#:- .01
	If KeyDown(Key_S) Then Intesity#:+ .01
	
	kCurrentMap.Update()
	kCurrentMap.LightArea(iDMX, iDMY, Lightness, Intesity#)
	kCurrentMap.LightArea((((MouseX() - (GraphicsWidth() / 2)) / 17)) + iDMX, (((MouseY() - (GraphicsHeight() / 2)) / 17)) + iDMY, 5, Intesity#, 255, 155, 0)'iDMX, iDMY, Lightness, Intesity#)
	kCurrentMap.Render()
	
	SetColor 255, 255, 255
	DrawText "DIABLO'S LIGHTING DEMO", 10, 10 + (1 * 12)
	DrawText "======================", 10, 10 + (2 * 12)
	DrawText "Lightness: " + Lightness + " (Use 'Q' & 'W' to change)", 10, 10 + (3 * 12)
	DrawText "Intesity:" + Intesity# + " (Use 'A' & 'S' to change)", 10, 10 + (4 * 12)
	'DrawText (MouseX() / 17) + ", " + (MouseY() / 17), 10, 34

	
	Flip
	
	FlushMem
	
Wend

EndGraphics
End

