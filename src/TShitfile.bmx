

Rem
shitfile("init/art.dat")
shitfile("init/config.dat")
shitfile("init/rek.dat")
shitfile("init/rek1.dat")
shitfile("init/rek2.dat")
End Rem


Rem
unshitfile("init/art.dat")
unshitfile("init/config.dat")
unshitfile("init/rek.dat")
unshitfile("init/rek1.dat")
unshitfile("init/rek2.dat")
End Rem






Function shitFile(aname:String)
		Local file:TStream = OpenFile(aname)
		If Not file Throw "could not open file " + aname

		Local lines:Byte[]

		While Not Eof(file)
			Local feld:Byte = ReadByte(file)
			
			lines = lines[..Len(lines)+1]
			lines[Len(lines)-1] = feld
			
			lines[Len(lines)-1]:-7
		Wend
		
		CloseFile(file)
		
		DeleteFile(aname)
		CreateFile(aname)

		file:TStream = OpenFile(aname)
		If Not file Throw "could not open file " + aname
		For Local t:Byte = EachIn lines
			WriteByte ( file, t )
		Next
		
		CloseFile (file)		

End Function



Function unshitFile(aname:String)
		Local file:TStream = OpenFile(aname)
		If Not file Throw "could not open file " + aname

		Local lines:Byte[]

		While Not Eof(file)
			Local feld:Byte = ReadByte(file)
			
			lines = lines[..Len(lines)+1]
			lines[Len(lines)-1] = feld
			
			lines[Len(lines)-1]:+7
		Wend

		DeleteFile(aname)
		CreateFile(aname)

		file:TStream = OpenFile(aname)
		If Not file Throw "could not open file " + aname
				
		
		For Local t:Byte = EachIn lines
			WriteByte ( file, t )
		Next
		
		CloseFile (file)	
End Function


