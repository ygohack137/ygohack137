--Painful Decision
function c13790665.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,13790665)
	e1:SetTarget(c13790665.target)
	e1:SetOperation(c13790665.activate)
	c:RegisterEffect(e1)
end
function c13790665.filter(c,tp)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToGrave()
		and Duel.IsExistingMatchingCard(c13790665.filter2,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c13790665.filter2(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function c13790665.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK) and chkc:IsControler(tp) and c13790665.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c13790665.filter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c13790665.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c13790665.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local tc=g:GetFirst()
		local hc=Duel.GetFirstMatchingCard(c13790665.filter2,tp,LOCATION_DECK,0,nil,tc:GetCode())
		if hc then
			Duel.SendtoHand(hc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,hc)
		end
	end
end
