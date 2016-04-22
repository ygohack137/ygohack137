--Dimension Sphinx
function c13701647.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c13701647.target)
	e1:SetOperation(c13701647.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c13701647.condition)
	e1:SetOperation(c13701647.operation2)
	c:RegisterEffect(e1)
end
function c13701647.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
function c13701647.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c13701647.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c13701647.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end

function c13701647.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	local bt=Duel.GetAttackTarget()
	return bt and bt:IsControler(tp) and bt==e:GetHandler():GetEquipTarget() and at:GetAttack()>bt:GetAttack()
end
function c13701647.operation2(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	local bt=Duel.GetAttackTarget()
	local dif=at:GetAttack()-bt:GetAttack()
	Duel.Damage(1-tp,dif,REASON_EFFECT)
end
