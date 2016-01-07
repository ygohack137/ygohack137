--Drifting Spirit Sakura
function c13790829.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13790829,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,13790829)
	e1:SetCondition(c13790829.con)
	e1:SetCost(c13790829.cost)
	e1:SetTarget(c13790829.tg)
	e1:SetOperation(c13790829.op)
	c:RegisterEffect(e1)

end
function c13790829.con(e,tp,eg,ep,ev,re,r,rp)
	local cmz=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local omz=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	return cmz<omz
end
function c13790829.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end

function c13790829.rmfilter(c)
	return c:IsAbleToRemove()
end
function c13790829.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13790829.rmfilter,tp,0,LOCATION_EXTRA,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_EXTRA)
end
function c13790829.op(e,tp,eg,ep,ev,re,r,rp)
	local pmd=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.ConfirmCards(1-tp,pmd)
	local ac=pmd:GetFirst():GetCode()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_EXTRA,nil,ac)
	local hg=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	Duel.ConfirmCards(tp,hg)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
