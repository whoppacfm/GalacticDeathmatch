      
Type TSchild
	Field energie:Int
	Field Image:TImage
	Field ImagePath:String
	
	Function Create:TSchild(energie:Int,ImagePath:String)
		Local schild:TSchild = New TSchild
		schild.energie = energie
		schild.ImagePath = ImagePath
		schild.Image = LoadImage(ImagePath)
		MidHandleImage(schild.Image)		             
		Return schild
	End Function
End Type



Type TSchilde   
	Field schildliste:TList
	
	Function Create:TSchilde()
		Local schil:TSchilde = New TSchilde
		schil.schildliste = CreateList()	
		Return schil
	End Function
		                          
	Method AddSchild(schild:TSchild)
		schildliste.AddLast(schild)		
	End Method		
End Type