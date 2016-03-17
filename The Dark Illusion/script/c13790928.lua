--Nirvana High Paladin
function c13790928.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsType,TYPE_SYNCHRO),1)
	c:EnableReviveLimit()
	--2sunchro summon
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(13790928,0))
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c13790928.syncon)
	e0:SetOperation(c13790928.synop)
	e0:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e0)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	------Pendulum Effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c13790928.condition)
	e1:SetOperation(c13790928.activate)
	c:RegisterEffect(e1)	
	------Monster Effect
	--Recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c13790928.thcon)
	e1:SetTarget(c13790928.thtg)
	e1:SetOperation(c13790928.thop)
	c:RegisterEffect(e1)
	--Halve LP
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c13790928.con)
	e1:SetOperation(c13790928.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c13790928.pencon)
	e2:SetTarget(c13790928.pentg)
	e2:SetOperation(c13790928.penop)
	c:RegisterEffect(e2)
end
------Pendulum Effect
function c13790928.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetAttacker():IsType(TYPE_PENDULUM)
end
function c13790928.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local c=e:GetHandler()
	if a then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e1,tp)
		--atkdown
		local e3=Effect.CreateEffect(c)
		e3:SetCategory(CATEGORY_ATKCHANGE)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetRange(LOCATION_PZONE)
		e3:SetCode(EVENT_DAMAGE_STEP_END)
		e3:SetOperation(c13790928.atkop)
		e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
		e3:SetLabel(a:GetAttack())
		c:RegisterEffect(e3)
	end
end
function c13790928.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c13790928.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	local atk=e:GetLabel()
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
--2SynchroSummon
function c13790928.mfilter(c,sync)
	return c:IsFaceup()
end
function c13790928.synfilter1(c,g)
	local tlv=10
	local synlv=tlv-c:GetLevel()
	return c:IsFaceup() and (not c:IsType(TYPE_TUNER) and  c:IsType(TYPE_PENDULUM) and c:GetSummonType()==SUMMON_TYPE_PENDULUM) and g:IsExists(c13790928.synfilter2,1,c,synlv)
end
function c13790928.synfilter2(c,lv)
	return c:GetLevel()==lv and  c:IsType(TYPE_SYNCHRO)
end
function c13790928.syncon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c13790928.mfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and mg:IsExists(c13790928.synfilter1,1,nil,mg)
end
function c13790928.synop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local mg=Duel.GetMatchingGroup(c13790928.mfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	g=mg:FilterSelect(tp,c13790928.synfilter1,1,1,nil,mg)
	local tc1=g:GetFirst()
		
	local mlv=10
	local synlv=mlv-tc1:GetLevel()
	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g2=mg:FilterSelect(tp,c13790928.synfilter2,1,1,tc1,synlv)
	local tc2=g2:GetFirst()
	g:Merge(g2)
	
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_RULE)
end
------Monster Effect
--Halve
function c13790928.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function c13790928.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2)
end

--to pendulumZ
function c13790928.pencon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c13790928.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)
	if chk==0 then return b1 end
end
function c13790928.penop(e,tp,eg,ep,ev,re,r,rp)
	local b1=Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)
	if b1 and e:GetHandler():IsRelateToEffect(e) then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end

--recover
function c13790928.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_SYNCHRO and c:GetMaterial():IsExists(c13790928.pmfilter,1,nil)
end
function c13790928.thfilter(c)
	return c:IsAbleToHand()
end
function c13790928.pmfilter(c)
	return c:IsType(TYPE_PENDULUM)
end
function c13790928.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c13790928.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13790928.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c13790928.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c13790928.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
