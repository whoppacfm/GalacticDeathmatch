
addspeed()

if (getenemywinkel() > getwinkel() - 20) and (getenemywinkel() < getwinkel() + 20) and (getenemydif() < 600) then
  shoot()
end

/goxy(1833,1898)
goxy(1733,1774)

/goenemy()


/Flammenwerfer holen bzw Munition auffüllen
/if (not haveweapon(3)) or (getweaponammo(3) < 1) then 
/  if itemvisible(3) then
/    goitem(3)
/  end
/end


/Booster holen / benutzen
/if haveitem(21) then
/  if getenemydif() > 500 then
/    useitem(21)
/  end
/else
/  if itemvisible(21) then
/    goitem(21)
/  end
/end


/Immer beste Waffe benutzen
/ -> Waffe nach Reichweite auswählen und benutzten
for i = 0, 4, 1 do
  if haveweapon(i) then
    if (getweaponammo(i) > 0) or (getweaponammo(i) == -5) then
      setweapon(i)    
    end
  end 
end


/Feindkontakt
/if getenemydif() > 300 then
/  goenemy()
/else
/  if not astaronline() then
/    if getenemywinkel() > getwinkel() then
/      goright()
/    elseif getenemywinkel() < getwinkel() then
/      goleft()
/    end  
/  end
/end


