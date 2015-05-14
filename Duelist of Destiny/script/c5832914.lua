--Toon Briefcase
function c5832914.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c5832914.condition)
	e1:SetTarget(c5832914.target)
	e1:SetOperation(c5832914.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
end
function c5832914.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c5832914.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c5832914.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c5832914.filter(c,tp)
	return c:GetSummonPlayer()~=tp and c:IsAbleToDeck()
end
function c5832914.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c5832914.filter,nil,tp)
	local ct=g:GetCount()
	if chk==0 then return ct>0 end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,ct,0,0)
end
function c5832914.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c5832914.filter,nil,tp):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		local ct=Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
