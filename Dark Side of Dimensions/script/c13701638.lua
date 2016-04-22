--Gate of the Magical Contract
function c13701638.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13701638.target)
	e1:SetOperation(c13701638.activate)
	c:RegisterEffect(e1)
end
function c13701638.filter1(c)
	return c:IsType(TYPE_SPELL)
end
function c13701638.filter(c)
	return (c:GetLevel()==8 or c:GetLevel()==7) and c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function c13701638.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13701638.filter1,tp,LOCATION_HAND,0,1,e:GetHandler()) and
	Duel.IsExistingMatchingCard(c13701638.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13701638.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13701638.filter1,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
	Duel.SendtoHand(g,1-tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,c13701638.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g2:GetCount()>0 then
		Duel.SendtoHand(g2,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g2)
	end
end
