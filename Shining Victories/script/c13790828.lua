--Performapal Odd-Eyes Light Phoenix
function c13790828.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c13790828.descon)
	e1:SetTarget(c13790828.destg)
	e1:SetOperation(c13790828.desop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(59546797,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCondition(c13790828.atkcon)
	e2:SetCost(c13790828.atkcost)
	e2:SetTarget(c13790828.atktg)
	e2:SetOperation(c13790828.atkop)
	c:RegisterEffect(e2)
end
function c13790828.descon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	return Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq) and Duel.GetTurnPlayer()~=tp
	and Duel.GetAttackTarget()==nil
end
function c13790828.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	local sc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and sc:IsDestructable()
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(sc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13790828.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c13790828.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c13790828.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c13790828.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c13790828.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() and chkc:IsSetCard(0x9f) end
	if chk==0 then return Duel.IsExistingTarget(c13790828.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c13790828.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c13790828.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1000)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
end
