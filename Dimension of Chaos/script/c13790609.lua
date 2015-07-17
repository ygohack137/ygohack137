--Fluffal Wing
function c13790609.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24508238,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,13790609)
	e1:SetCost(c13790609.cost)
	e1:SetTarget(c13790609.target)
	e1:SetOperation(c13790609.operation)
	c:RegisterEffect(e1)
end
function c13790609.filter(c)
	return c:IsSetCard(0xa9) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c13790609.filter2(c)
	return c:IsFaceup() and c:IsCode(70245411) and c:IsAbleToGrave()
end
function c13790609.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c13790609.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()==tp and chkc:GetLocation()==LOCATION_GRAVE and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(c13790609.filter,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsPlayerCanDraw(tp,1) 
	and Duel.IsExistingMatchingCard(c13790609.filter2,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c13790609.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c13790609.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
		if Duel.IsExistingMatchingCard(c13790609.filter2,tp,LOCATION_SZONE,0,1,nil) and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,aux.Stringid(13790609,0)) then
			Duel.BreakEffect()
			local g=Duel.SelectMatchingCard(tp,c13790609.filter2,tp,LOCATION_SZONE,0,1,1,nil)
			Duel.SendtoGrave(g,REASON_EFFECT)
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
