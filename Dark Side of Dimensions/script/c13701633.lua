--Houkai Reincarnation
function c13701633.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c13701633.condition)
	e1:SetTarget(c13701633.target)
	e1:SetOperation(c13701633.activate)
	c:RegisterEffect(e1)
end
function c13701633.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()==nil
end
function c13701633.nfilter(c,code)
	return c:IsCode(code)
end
function c13701633.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c13701633.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp)end
	Duel.SetTargetCard(tg)
end

function c13701633.spfilter2(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,1-tp,false,false,POS_FACEUP)
end
function c13701633.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetAttacker()
	if not tc1:IsRelateToEffect(e) then return end
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft<=0 then return end
	local c=e:GetHandler()
	local code=tc1:GetCode()
	local g=Duel.SelectMatchingCard(1-tp,c13701633.spfilter2,1-tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,ft,ft,nil,code,e,tp)
	local tc=g:GetFirst()
	while tc do
		if Duel.SpecialSummonStep(tc,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK) then
			c:SetCardTarget(tc)
			tc:AddCounter(0xe3,1)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetCondition(c13701633.atcon)
			tc:RegisterEffect(e1)		
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE)
			e2:SetCondition(c13701633.atcon)
			tc:RegisterEffect(e2)
		
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	end
		tc1:AddCounter(0xe3,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc1:RegisterEffect(e1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetCondition(c13701633.atcon)
		tc1:RegisterEffect(e1)		
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetCondition(c13701633.atcon)
		tc1:RegisterEffect(e2)
	local g1=Duel.SelectMatchingCard(tp,c13701633.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc2=g1:GetFirst()
	if tc2 and Duel.SpecialSummonStep(tc2,0,tp,tp,true,false,POS_FACEUP) then
	Duel.SpecialSummonComplete()
	end
end
function c13701633.atcon(e)
	return e:GetHandler():GetCounter(0xe3)>0
end
function c13701633.spfilter(c,e,tp)
	return c:IsSetCard(0xe3) and c:IsLevelBelow(4) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end

