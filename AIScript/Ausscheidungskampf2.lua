
addspeed()


/if getenemydif() < 400 then stopgoing()


/Alle Waffen holen
/for i = 0, 9, 1 do
/  if iteminlevel(i) then
/    if (not haveweapon(i)) or (getweaponammo(i) < 1) then 
/      if itemvisible(i) then
/        goitem(i)
/      end
/    end
/  end
/end


/Flammenwerfer holen bzw Munition auffüllen
/if (not haveweapon(3)) or (getweaponammo(3) < 1) then 
/  if itemvisible(3) then
/    goitem(3)
/  end
/end


/Powerlaser holen bzw Munition auffüllen
/if (not haveweapon(2)) or (getweaponammo(2) < 1) then 
/  if itemvisible(2) then
/    goitem(2)
/  end
/end


/Minen holen bzw Munition auffüllen
if (not haveweapon(6)) or (getweaponammo(6) < 1) then 
  if itemvisible(6) then
    if not astaronline() then
      setvar(0,getvar(0)+1)
    end     
    goitem(6)
  end
end



/Wenn Minen vorhanden sind sofort ablegen
if haveweapon(6) and getweaponammo(6) > 1 then
  setweapon(6)
  shoot()
end


/Booster holen / benutzen
if getboosterenergy() > 1 then
  if getenemydif() > 600 then
    usebooster()
  end
else
  if itemvisible(21) then
    goitem(21)
  end
end


/Immer beste Waffe benutzen
/ -> Waffe nach Reichweite auswählen und benutzen
/for i = 0, 9, 1 do
/  if haveweapon(i) then
/    if (getweaponammo(i) > 0) or (getweaponammo(i) == -5) then
/      setweapon(i)    
/    end
/  end 
/end




/Health holen
if getshieldenergy() < getstandardshield()/1.5 then
  if itemvisible(22) then  
    goitem(22)
  end
end


/Zusatzschild holen
if getbonusshieldenergy() < getstandardbonusshield() then
  if itemvisible(31) then  
    goitem(31)
  end
end



/Feindkontakt
/if getenemydif() > 400 then
  /goenemy()
/end



if getvar(0) < 3 then
  if getweaponammo(6) > 5 then
    if gety() < 1200 then 
      goxy(1400,1700)
    end

    /Minen verteilen
    if getx() < 200 then
      goxy(1200,1700)
    end

    if getx() > 1100 then
      goxy(150,1400)
    end
  end
else
  if getenemydif() > 700 then
    goxy(600,1300)
  else
    if gety() < 1300 then    
      goxy(1400,1700)
    end
  end   
end



/Zweikampf
if not astaronline() then
  if (getenemywinkel() > getwinkel() + 140) or (getenemywinkel() < getwinkel() - 140) then
    stop()
    goleft()
  else

    /Feind auf Distanz halten
    if routecleartoenemy() then    
      if getenemywinkel() > getwinkel() then
        goright()
      elseif getenemywinkel() < getwinkel() then
        goleft()
      end  

      if getweaponrange() > getenemydif() then
        if (getenemywinkel() > getwinkel() - 10) and (getenemywinkel() < getwinkel() + 10) then        
          subspeed()
        end
      end
    else
      /goenemy()
    end
  end
end




if getactualweapon() == 8 then
  if (getenemywinkel() > getwinkel() - 5) and (getenemywinkel() < getwinkel() + 5) and (getenemydif() < getweaponrange()) then
    if routecleartoenemy() then
      shoot()
    end
  end
else
  if (getenemywinkel() > getwinkel() - 20) and (getenemywinkel() < getwinkel() + 20) and (getenemydif() < getweaponrange()) then
    if routecleartoenemy() then
      setweapon(1)
      shoot()
    end
  end
end



