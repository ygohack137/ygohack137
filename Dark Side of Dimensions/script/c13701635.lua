--Houkai Mandala
function c13701635.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c13701635.sptg)
	e1:SetOperation(c13701635.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAIN_ACTIVATING)
	e2:SetOperation(c13701635.disop)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c13701635.descon)
	e3:SetOperation(c13701635.desop)
	c:RegisterEffect(e3)
end
function c13701635.filter(c,e,tp,tid)
	return c:GetTurnID()==tid and bit.band(c:GetReason(),REASON_DESTROY)~=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13701635.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c13701635.filter(chkc,e,tp,tid) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c13701635.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp,tid) end
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c13701635.filter,tp,0,LOCATION_GRAVE,1,ft,nil,e,tp,tid)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c13701635.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if g:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		g=g:Select(tp,ft,ft,nil)
	end
	local c=e:GetHandler()
	local tc=g:GetFirst()
	while tc do
		if Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP) then
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
			e1:SetCondition(c13701635.atcon)
			tc:RegisterEffect(e1)		
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE)
			e2:SetCondition(c13701635.atcon)
			tc:RegisterEffect(e2)
		end
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
function c13701635.atcon(e)
	return e:GetHandler():GetCounter(0xe3)>0
end

function c13701635.disop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetCardTargetCount()~=0  and not re:GetHandler():GetControler()==tp and (re:GetHandler():IsType(TYPE_MONSTER))then
		Duel.NegateEffect(ev)
	end
end

function c13701635.dfilter(c,sg)
	return sg:IsContains(c)
end
function c13701635.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCardTargetCount()~=0 then return false end
	return c:GetCardTarget():IsExists(c13701635.dfilter,1,nil,eg)
end
function c13701635.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
