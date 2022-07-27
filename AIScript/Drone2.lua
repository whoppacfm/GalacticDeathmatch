addspeed()

if getenemywinkel() > getwinkel() then
  subspeed()
  goright()
elseif getenemywinkel() < getwinkel() then
  subspeed()
  goleft()
end

if getenemydif() > 400 then
  addspeed()
else
  subspeed()
end

if (getenemywinkel() > getwinkel() - 10) and (getenemywinkel() < getwinkel() + 10) and (getenemydif() < 500) then
  shoot()
end
