public


global tile_width:int = 122
global tile_height:int = 122
'SetBlend ALPHABLEND
Global img_tileset:TImage = LoadAnimImage("images/final2.png",tile_width,tile_height,0,16)
Global tile_specs:String[16]
tile_specs[0] = "0000"
tile_specs[1] = "1111"
tile_specs[2] = "0011"
tile_specs[3] = "1100"
tile_specs[4] = "1010"
tile_specs[5] = "0101"
tile_specs[6] = "0001"
tile_specs[7] = "0010"
tile_specs[8] = "0100"
tile_specs[9] = "1000"
tile_specs[10] = "0110"
tile_specs[11] = "1001"
tile_specs[12] = "1011"
tile_specs[13] = "0111"
tile_specs[14] = "1110"
tile_specs[15] = "1101"


Global tile_matrix:Int[20,15]

rem 
While Not KeyHit(KEY_ESCAPE)
	Cls

	Local tile_x:Int = MouseX()/tile_width
	Local tile_y:Int = MouseY()/tile_height

	If MouseDown(1)
  	CreateIsland(tile_x,tile_y)
	End If

	DrawMap()

	SetColor 255,255,255
	SetAlpha 0.5
	DrawRect(tile_x*tile_width),(tile_y*tile_height),tile_width,tile_height
	SetAlpha 1.0
	
	Flip
	FlushMem()
Wend

End
end rem 



Function DrawMap(deltax,deltay:Int)
	'setcolor 255,255,255
	'setblend maskblend
	'setalpha 1
	For Local x:Byte = 0 To 19
		For Local y:Byte = 0 To 14
			setrotation 0
			DrawImage img_tileset,(x*tile_width)-deltax,(y*tile_height)-deltay,tile_matrix[x,y]
		Next
	Next
End Function


Function CreateIsland(x:Int,y:Int)

	If x>0 And y>0 And x<19 And y<14
		tile_matrix[x,y] = 1

		AlignTile1(x, y)
		AlignTile2(x, y)
		AlignTile3(x, y)
		AlignTile4(x, y)
		AlignTile5(x, y)
		AlignTile6(x, y)
		AlignTile7(x, y)
		AlignTile8(x, y)
 End If
End Function


Function AlignTile1(x:Int,y:Int)
	Local tile_def:String = tile_specs[tile_matrix[x-1,y-1]]
	tile_def = Mid(tile_def,1,3)+"1"
	tile_matrix[x-1, y-1] = GetTile(tile_def)
End Function

Function AlignTile2(x:Int,y:Int)
	Local tile_def:String = tile_specs[tile_matrix[x,y-1]]
	tile_def = Mid(tile_def,1,2)+"11"
	tile_matrix[x,y-1] = GetTile(tile_def)
End Function 

Function AlignTile3(x:Int,y:Int)
	Local tile_def:String = tile_specs[tile_matrix[x+1,y-1]]
	tile_def = Mid(tile_def,1,2)+"1"+Mid(tile_def,4,1)
	tile_matrix[x+1,y-1] = GetTile(tile_def)
End Function 

Function AlignTile4(x:Int,y:Int)
	Local tile_def:String = tile_specs[tile_matrix[x+1, y]]
	tile_def = "1"+Mid(tile_def,2,1)+"1"+Mid(tile_def,4,1)
	tile_matrix[x+1,y] = GetTile(tile_def)
End Function 

Function AlignTile5(x:Int,y:Int)
	Local tile_def:String = tile_specs[tile_matrix[x+1,y+1]]
	tile_def = "1"+Mid(tile_def,2,3)
	tile_matrix[x+1,y+1] = GetTile(tile_def)
End Function 

Function AlignTile6(x:Int,y:Int)
	Local tile_def:String = tile_specs[tile_matrix[x, y+1]]
	tile_def = "11"+Mid(tile_def,3,2)
	tile_matrix[x,y+1] = GetTile(tile_def)
End Function 

Function AlignTile7(x:Int,y:Int)
	Local tile_def:String = tile_specs[tile_matrix[x-1,y+1]]
	tile_def = Mid(tile_def,1,1)+"1"+Mid(tile_def,3,2)
	tile_matrix[x-1,y+1] = GetTile(tile_def)
End Function 

Function AlignTile8(x:Int,y:Int)
	Local tile_def:String = tile_specs[tile_matrix[x-1, y]]
	tile_def = Mid(tile_def,1,1)+"1"+Mid(tile_def,3,1)+"1"
	tile_matrix[x-1,y] = GetTile(tile_def)
End Function 


Function GetTile(tile:String)
	For Local i:Byte = 0 To 15
 		If tile = tile_specs[i] Then Return i
	Next
End Function


