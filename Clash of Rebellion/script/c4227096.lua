--Wrongful Arrest
function c4227096.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c4227096.activate)
	c:RegisterEffect(e1)
end
function c4227096.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TO_HAND)
	e1:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	e1:SetReset(RESET_SELF_TURN+RESET_PHASE+RESET_END,2)
	Duel.RegisterEffect(e1,tp)
end
