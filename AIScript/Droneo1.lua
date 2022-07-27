/addspeed()

if getenemywinkel() > getwinkel() then
  goright()
elseif getenemywinkel() < getwinkel() then
  goleft()
end

if (getenemywinkel() > getwinkel() - 20) and (getenemywinkel() < getwinkel() + 20) and (getenemydif() < 400) then
  shoot()
end

if (getenemydif() < 400) then
  addspeed()
end 
