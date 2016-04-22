--Dimension Mirage
function c13701621.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c13701621.target)
	e1:SetOperation(c13701621.operation)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6330307,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c13701621.atkcon)
	e3:SetOperation(c13701621.atkop)
	c:RegisterEffect(e3)
end
function c13701621.filter(c)
	return c:IsFaceup() and c:IsAttackPos()
end
function c13701621.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c13701621.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13701621.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPATTACK)
	Duel.SelectTarget(tp,c13701621.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c13701621.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
	end
end
function c13701621.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c13701621.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13701621.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13701621.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c13701621.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return at and a==e:GetHandler():IsHasCardTarget(e:GetHandler()) and at:IsRelateToBattle() and  a:IsChainAttackable()
end
function c13701621.atkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if at:IsRelateToBattle() and not at:IsImmuneToEffect(e) then
		Duel.ChainAttack(at)
	end
end
