--Dimension Mirage
function c13701646.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c13701646.target)
	e1:SetOperation(c13701646.operation)
	c:RegisterEffect(e1)
	--Destroy2
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c13701646.descon2)
	e2:SetOperation(c13701646.desop2)
	c:RegisterEffect(e2)
	--chain attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6330307,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c13701646.cost)
	e3:SetCondition(c13701646.atkcon)
	e3:SetOperation(c13701646.atkop)
	c:RegisterEffect(e3)
end
function c13701646.filter(c)
	return c:IsFaceup() and c:IsAttackPos()
end
function c13701646.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c13701646.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13701646.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPATTACK)
	Duel.SelectTarget(tp,c13701646.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c13701646.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		Duel.Equip(tp,c,tc,true)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c13701646.eqlimit)
		e1:SetLabelObject(tc)
		c:RegisterEffect(e1)
	end
end
function c13701646.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c13701646.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13701646.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cg=Duel.SelectMatchingCard(tp,c13701646.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(cg,POS_FACEUP,REASON_COST)
end

function c13701646.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return at and a==e:GetHandler():GetEquipTarget() and at:IsRelateToBattle() and at:GetAttack()>0 and a:IsChainAttackable()
end
function c13701646.atkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if at:IsRelateToBattle() and not at:IsImmuneToEffect(e) then
		Duel.CalculateDamage(ec,at)
	end
end

function c13701646.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c13701646.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(), REASON_EFFECT)
end
