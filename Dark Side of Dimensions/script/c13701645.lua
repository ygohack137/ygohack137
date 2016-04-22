--Krystal Avatar
function c13701645.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,13701645+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c13701645.condition)
	e1:SetTarget(c13701645.target)
	e1:SetOperation(c13701645.activate)
	c:RegisterEffect(e1)
end
function c13701645.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and Duel.GetAttackTarget()==nil and at:GetAttack()>=Duel.GetLP(tp)
end
function c13701645.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
		Duel.IsPlayerCanSpecialSummonMonster(tp,13701645,0,0x21,Duel.GetLP(tp),0,4,RACE_WARRIOR,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13701645.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,13701645,0,0x21,Duel.GetLP(tp),0,4,RACE_WARRIOR,ATTRIBUTE_LIGHT) then return end
	c:AddTrapMonsterAttribute(TYPE_EFFECT,ATTRIBUTE_LIGHT,RACE_WARRIOR,4,Duel.GetLP(tp),0)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	c:TrapMonsterBlock()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13701645,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c13701645.damcon)
	e1:SetOperation(c13701645.damop)
	e1:SetReset(RESET_EVENT+0x17e0000)
	e1:SetLabel(Duel.GetLP(tp))
	c:RegisterEffect(e1)
end
function c13701645.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_BATTLE)
end
function c13701645.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,e:GetLabel(),REASON_EFFECT)
end
