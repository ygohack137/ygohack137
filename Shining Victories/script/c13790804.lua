--Dinomist Spinos
--By: HelixReactor
function c13790804.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c13790804.reptg)
	e2:SetValue(c13790804.repval)
	e2:SetOperation(c13790804.repop)
	c:RegisterEffect(e2)
	--Attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c13790804.atkcost)
	e3:SetTarget(c13790804.atktg)
	e3:SetOperation(c13790804.atkop)
	c:RegisterEffect(e3)
end
function c13790804.xfilter(c,tp)
	return c:IsFaceup() and (c:IsControler(tp) and c:IsSetCard(0x1e71) and c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT))
end
function c13790804.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not eg:IsContains(e:GetHandler())
		and eg:IsExists(c13790804.xfilter,1,nil,tp) and not e:GetHandler():IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectYesNo(tp,aux.Stringid(13790804,0))
end
function c13790804.repval(e,c)
	return c13790804.xfilter(c,e:GetHandlerPlayer())
end
function c13790804.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
function c13790804.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,c,0x1e71) end
	local rg=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,c,0x1e71)
	Duel.Release(rg,REASON_COST)
end
function c13790804.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local con1=c:GetFlagEffect(13790804)==0
	local con2=c:GetFlagEffect(72001825)==0
	if chk==0 then return con1 or con2 end
	local op
	if con1 and con2 then
		op=Duel.SelectOption(tp,aux.Stringid(13790804,1),aux.Stringid(13790804,2))
	elseif con1 and not con2 then
		op=Duel.SelectOption(tp,aux.Stringid(13790804,1))
	elseif not con1 and con2 then
		op=Duel.SelectOption(tp,aux.Stringid(13790804,2))+1
	end
	e:SetLabel(op)
end
function c13790804.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local op=e:GetLabel()
	if op==0 then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			c:RegisterFlagEffect(13790804,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,0)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DIRECT_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	elseif op==1 then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			c:RegisterFlagEffect(72001825,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,0)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_EXTRA_ATTACK)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e2)
		end
	end
end
