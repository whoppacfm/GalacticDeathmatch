
addspeed()


/Feindkontakt
if (getenemydif() > 500) or (not routecleartoenemy()) then
  goenemy()
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
      goenemy()
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
      shoot()
    end
  end
end


