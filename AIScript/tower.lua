/addspeed()

if getenemywinkel() > getwinkel() then
  goright()
elseif getenemywinkel() < getwinkel() then
  goleft()
end

if getenemywinkel() < 400 then
  if (getenemywinkel() > getwinkel() - 10) and (getenemywinkel() < getwinkel() + 10) and (getenemydif() < 600) then
    shoot()
  end
end

