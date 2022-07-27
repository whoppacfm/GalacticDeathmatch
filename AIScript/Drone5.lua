addspeed()

if getenemywinkel() > getwinkel() then
  goright()
elseif getenemywinkel() < getwinkel() then
  goleft()
end

/if (getenemywinkel() > getwinkel() - 10) and (getenemywinkel() < getwinkel() + 10) and (getenemydif() < 500) then
/  shoot()
/end

if getenemydif() < 700 then
  shoot()
end
