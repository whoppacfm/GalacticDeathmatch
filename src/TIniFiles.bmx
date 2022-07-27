'Funktionen um eigenes Ini-File Format zu lesen/schreiben
'August 2005, Christian Merz 

public

function INI_GetValue:String(filename$,key$,defaultv$)
	local backValue$=defaultv
	local file:TStream = readfile(filename)
	if not file throw "could not open file " + filename
	while not eof(file)
		local feld$ = readline(file)
		if feld.trim() = "" then continue 
		local index% = feld.find("=")
		local value1$ = feld[index+1..]
		feld = feld[..index]
		if feld.tolower() = key.tolower() then
			backValue = value1
			exit
		end if
	wend	
	closefile file
	return backvalue
End Function


'öffnet datei/erstellt datei wenn nicht da und ersetzt/fügt hinzu key=value
function INI_SetValue:int(filename$,key$,value$)
	local file:TStream = openfile(filename)
	local found
	if not file then
		createfile filename'throw "could not open file " + filename
		file:TStream = openfile(filename)
	end if
	
	Local tempcfg:TList = New TList
	
	while not eof(file)
		Local tempstring:String = ReadLine$(file)
		local temp:String
		if tempstring.trim() <> "" then
			local index% = tempstring.find("=")
			temp = tempstring[..index]
			temp = trim(temp)
					
			If temp.tolower() = key.tolower()
				Local newstring:String = key + "=" + value
				tempcfg.AddLast newstring
				found = True
			Else
				tempcfg.AddLast tempstring
			EndIf
		end if
	Wend
				
	Closefile (file)
	DeleteFile (filename)
	CreateFile (filename)
	file = OpenFile (filename)
	For Local t$ = EachIn tempcfg
		WriteLine ( file, t )
	Next
	
	if found = False
		WriteString (file, key + "=" + value)
	EndIf
	Closefile (file)
		
	return 1
end function







