

rem 
graphics 1024,768


Local I:Int
drawtext "Return_strip2 : ('Load Map:Test.dat')",100,100

Local Strip:String[]
Strip = Return_Strip2("3000,3000,images/weltall1.png", ",,")
For I = 0 To Strip.length-1
	drawtext I + " : " + Strip[I],100,150+i*20
Next


drawtext "Return_strip  : ('Load Map:Test.dat')",600,100

Local Strip2:String[]
Strip2 = Return_Strip("fdsf,fdsf,erew,cvxv", ",")
For I = 0 To Strip2.length-1
	drawtext I + " : " + Strip2[I],600,150+i*20
Next


flip

while not keyhit(KEY_ESCAPE)
	
	
wend
end rem 



Function Return_Strip2:String[](_String:String,_strip:String)
	Local Text_Array : String[1]
    Local R_Text:String = _string
    Local i:Int = 0

    Repeat
    	If R_Text.Length = 0 Then Exit
        
		Local sp_p:Int = R_Text.Find(Mid(_strip,I+1,1))
        If sp_p = - 1 Or I > _strip.length -1 Then
        	Text_Array[I] = R_Text
            Exit
        End If
        Text_Array[I] = Left(R_Text,sp_p)
        R_Text = Right(R_Text,(R_text.Length - sp_p)-1)
        I:+1
        Text_Array = Text_array[..I+1]	
	Forever
    Return Text_array       
       
End Function




Function Return_Strip:String[](_String:String,_strip:string)

        Local Text_Array : String[1]
        Local R_Text:String = _string
        Local i:Int = 0

        Repeat
                If R_Text.Length = 0 Then Exit
                        'Local sp_p:Int = R_Text.Find(Chr(_strip))
						Local sp_p:Int = R_Text.Find(_strip,0)
                        If sp_p = - 1  Then
                                Text_Array[I] = R_Text
                                Exit
                        End If
                        Text_Array[I] = Left(R_Text,sp_p)
                        R_Text = Right(R_Text,(R_text.Length - sp_p)-1)
                        I:+1
                        Text_Array = Text_array[..I+1]
        Forever
       
        Return Text_array       
       
End Function 

