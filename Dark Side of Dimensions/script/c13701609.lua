--Giant Sentry of Stone
function c13701609.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,13701609)
	e1:SetCondition(c13701609.condition)
	e1:SetTarget(c13701609.target)
	e1:SetOperation(c13701609.operation)
	c:RegisterEffect(e1)

end
function c13701609.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_ROCK)
end
function c13701609.cfilter2(c)
	return c:IsFaceup() and not c:IsRace(RACE_ROCK)
end
function c13701609.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13701609.filter,tp,LOCATION_MZONE,0,1,nil) and
	not Duel.IsExistingMatchingCard(c13701609.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function c13701609.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13701609.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
