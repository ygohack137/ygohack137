--Graceful Tears
function c13790847.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13790847.target)
	e1:SetOperation(c13790847.activate)
	c:RegisterEffect(e1)
end
function c13790847.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0
		and Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,e:GetHandler()) end
end
function c13790847.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local gc=g1:Select(tp,1,1,nil)
	Duel.SendtoHand(gc,1-tp,REASON_EFFECT)
	Duel.Recover(tp,2000,REASON_EFFECT)
end
