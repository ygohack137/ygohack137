--Illusion Magic
function c13790911.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,13790911)
	e1:SetCost(c13790911.cost)
	e1:SetTarget(c13790911.target)
	e1:SetOperation(c13790911.activate)
	c:RegisterEffect(e1)
end
function c13790911.cfilter(c)
	return c:IsRace(RACE_SPELLCASTER)
end
function c13790911.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c13790911.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c13790911.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c13790911.filter(c)
	return c:IsCode(46986414) and c:IsAbleToHand()
end
function c13790911.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13790911.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c13790911.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13790911.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

