--Fusiplotion
function c13701640.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c13701640.condition)
	e1:SetTarget(c13701640.target)
	e1:SetOperation(c13701640.activate)
	c:RegisterEffect(e1)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c13701640.descost)
	e1:SetCondition(c13701640.condition2)
	e1:SetTarget(c13701640.target)
	e1:SetOperation(c13701640.activate)
	c:RegisterEffect(e1)
end
function c13701640.cfilter(c,tp,re)
	return c:IsControler(tp) and c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY) and re:IsActiveType(TYPE_SPELL)
end
function c13701640.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13701640.cfilter,1,nil,tp,re)
end
function c13701640.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c13701640.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c13701640.condition2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13701640.cfilter,1,nil,tp,re) and Duel.GetTurnCount()~=e:GetHandler():GetTurnID() or e:GetHandler():IsReason(REASON_RETURN)
end

function c13701640.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
