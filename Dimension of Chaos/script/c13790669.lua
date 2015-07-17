--Covenant with the Seal Mistake
function c13790669.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetOperation(c13790669.activate1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c13790669.con)
	e2:SetOperation(c13790669.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1)
	e3:SetCondition(c13790669.damcon)
	e3:SetTarget(c13790669.damtg)
	e3:SetOperation(c13790669.damop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetValue(c13790669.efilter)
	c:RegisterEffect(e4)
end
function c13790669.efilter(e,te)
	return te:GetHandler():IsCode(13790669)
end
function c13790669.activate1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.IsExistingMatchingCard(c13790669.cfilter,tp,LOCATION_MZONE,0,1,nil)
	and Duel.SelectYesNo(tp,aux.Stringid(13790669,0)) then
		c13790669.activate(e,tp,eg,ep,ev,re,r,rp)
		e:GetHandler():RegisterFlagEffect(13790669,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		e:GetHandler():RegisterFlagEffect(0,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(40555959,2))
	end
end
function c13790669.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xaf)
end
function c13790669.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13790669.cfilter,tp,LOCATION_MZONE,0,1,nil)
	and e:GetHandler():GetFlagEffect(13790669)==0
end
function c13790669.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c13790669.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetOperation(c13790669.disoperation)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	--disable trap monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c13790669.distarget)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c13790669.distarget(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_TRAP)
end
function c13790669.disoperation(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP) and tl~=e:GetHandler() then
		Duel.NegateEffect(ev)
	end
end
function c13790669.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c13790669.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
end
function c13790669.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end

