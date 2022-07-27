Strict
include "TEffekte.bmx"

Graphics 1024,768


'SCHLANGE---------
local s:TSchlange = TSchlange.Create("../../sphere.png")
s.bobxpos = 200
s.bobypos = 200
s.bobWidth = 100
s.bobHeight = 100
s.maxbobs = 512
'------------------

'LICHER-----------------------
local h:TBlob2D = TBlob2D.create(80)
h.render
hidemouse
'------------------------------



While Not KeyHit(KEY_ESCAPE)
  Cls
  
  s.draw 
  
  h.draw(400,300)
  h.draw(MouseX(),MouseY())
    
  Flip
  flushmem
Wend




	


End




