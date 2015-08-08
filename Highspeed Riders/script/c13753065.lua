--Hidden Shot
function c13753065.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13753065.target)
	e1:SetOperation(c13753065.operation)
	c:RegisterEffect(e1)
end
function c13753065.desfilter(c)
	return c:IsDestructable()
end
function c13753065.cfilter(c)
	return c:IsSetCard(0x2016) and c:IsAbleToRemoveAsCost()
end
function c13753065.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13753065.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		and Duel.IsExistingMatchingCard(c13753065.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local dg=Duel.GetMatchingGroup(c13753065.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local ct=dg:GetCount()
	if ct>2 then ct=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c13753065.cfilter,tp,LOCATION_GRAVE,0,1,ct,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
	Duel.SetTargetParam(rg:GetCount())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,rg:GetCount(),0,0)
end
function c13753065.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c13753065.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,ct,ct,e:GetHandler())
	Duel.HintSelection(g)
	Duel.Destroy(g,REASON_EFFECT)
end
