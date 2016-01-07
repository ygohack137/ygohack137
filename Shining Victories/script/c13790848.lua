--Amorphage Lysis
function c13790848.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c13790848.atktg)
	e2:SetValue(c13790848.value)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_DEFENCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c13790848.atktg)
	e3:SetValue(c13790848.value)
	c:RegisterEffect(e3)
	--self destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_DESTROY)
	e4:SetCountLimit(1,13790848)
	e4:SetCondition(c13790848.descon)
	e4:SetOperation(c13790848.desop)
	c:RegisterEffect(e4)
end
function c13790848.atktg(e,c)
	return not c:IsSetCard(0x1d1) 
end
function c13790848.filt(c)
	return c:IsFaceup() and c:IsSetCard(0x1d1) 
end
function c13790848.value(e,c)
	return Duel.GetMatchingGroupCount(c13790848.filt,nil,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*-100
end

function c13790848.desfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_SZONE) and (c:GetSequence()==6 or c:GetSequence()==7)
end
function c13790848.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13790848.desfilter,1,nil,tp)
end
function c13790848.penfilter(c)
	return c:IsSetCard(0x1d1) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c13790848.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local g=Duel.SelectMatchingCard(tp,c13790848.penfilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
