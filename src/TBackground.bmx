'bewegende Sterne
'Christian Merz
'18.September 2005


Type TSterne
	Field starsx:Int[]
	Field starsy:Int[]
	Field starssx:Float[]
	Field starssy:Float[]
	Field starsw:Float[] 
	Field starsw2:Float[]
	Field sspeed:Float[] 
	Field sanzahl:Int=0
	Field sbubble:TImage
	Field mittex,mittey:Int
	
	Function create:TSterne(anzahl:Int,mittex,mittey:Int)
		Local sterne:TSterne = New TSterne
		Local i:Int
		sterne.sbubble:TImage = LoadImage("images/gradball.png")
		MidHandleImage(sterne.sbubble)
		sterne.sanzahl = anzahl
		sterne.starsx = New Int[anzahl]
		sterne.starsy = New Int[anzahl]
		sterne.starssx = New Float[anzahl]
		sterne.starssy = New Float[anzahl]
		sterne.starsw = New Float[anzahl]
		sterne.starsw2 = New Float[anzahl]
		sterne.sspeed = New Float[anzahl]
		sterne.mittex = mittex
		sterne.mittey = mittey
				
		For i=0 To anzahl - 1
			'SeedRnd MilliSecs()
'			sterne.starsx[i]=Rand(-10+mittex,10+mittex)
'			sterne.starsy[i]=Rand(-10+mittey,10+mittey)
			sterne.starsx[i]=Rand(-mittex,mittex)
			sterne.starsy[i]=Rand(-mittey,mittey)
			
			sterne.starssx[i]=Rnd(0.01,0.13)
			sterne.starssy[i]=Rnd(0.01,0.13)
			Local radi:Int
			If mittex > mittey Then 
				radi = mittex*2
			Else
				radi = mittey*2
			End If
			sterne.starsw[i]=Rnd(0,radi) ' radius
			sterne.starsw2[i]=Rnd(1,360) 'verteilung
			sterne.sspeed[i]=Rnd(0.006,0.04) 
		Next	
		Return sterne
	End Function
		
	
	Method draw(viewx,viewy:Int)
		SetColor 255,255,255

		'tileimage stern1,-viewx,-viewy

		SetRotation(0)
		SetBlend(ALPHABLEND)
		SetScale(0.7,0.7)
		SetScale(2,2)
		SetBlend alphablend

		Local li:Int
		For li=0 To starsw2.length-1  'sanzahl-1
			Local s:Float = Rnd(.1,.9)
		
			starsw2[li] = starsw2[li] + sspeed[li]
			If starsw2[li] > 360 Then starsw2[li] = 0
				
			'starsx[li] = starsx[li] - Cos(swinkel) * starsw[li]
			'starsy[li] = starsy[li] - Sin(swinkel) * starsw[li]

			starsx[li] = starsw[li] * Cos(starsw2[li])
			starsy[li] = starsw[li] * Sin(starsw2[li])
				
			'if starsx[li] > 3000 then starsx[li] = -3000
			'starsy[li] = starsx[li] + 5
		
			SetScale(starssx[li],starssy[li])
			SetAlpha(Rnd!(.5,1))
			DrawImage sbubble,starsx[li]-viewx+mittex-viewx,starsy[li]-viewy+mittey-viewy
			SetBlend alphablend
		Next
	
	End Method
	
End Type

