--Scapeghost
function c13790924.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c13790924.target)
	e1:SetOperation(c13790924.activate)
	c:RegisterEffect(e1)
end
function c13790924.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,137909241,0,0x4011,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c13790924.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return false end
	local tk=0
	if Duel.IsPlayerCanSpecialSummonMonster(tp,137909241,0,0x4011,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) then
		while Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(13790924,0)) do
			local token=Duel.CreateToken(tp,137909241+tk)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			tk=tk+1
		end
		Duel.SpecialSummonComplete()
	end
end
	
