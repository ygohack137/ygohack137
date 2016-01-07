--True Draco-Awakening
function c13790833.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c13790833.condition)
	e1:SetTarget(c13790833.target)
	e1:SetOperation(c13790833.activate)
	c:RegisterEffect(e1)
end
function c13790833.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0xc7) and not c:IsType(TYPE_PENDULUM)
end
function c13790833.cfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0xda)
end
function c13790833.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13790833.cfilter1,tp,LOCATION_MZONE,0,1,nil) and
	 Duel.IsExistingMatchingCard(c13790833.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function c13790833.filter(c)
	return c:IsAbleToDeck()
end
function c13790833.spfilter(c,e,tp)
	return (c:IsSetCard(0xc7) or c:IsSetCard(0xda)) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c13790833.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13790833.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c13790833.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c13790833.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c13790833.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if Duel.SendtoDeck(g,nil,2,REASON_EFFECT)>=1 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c13790833.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
