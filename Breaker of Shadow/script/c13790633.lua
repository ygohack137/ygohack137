--Dinomist Brachion
function c13790633.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable and destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_PZONE)
	e2:SetOperation(c13790633.disop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c13790633.spcon)
	c:RegisterEffect(e3)
end
function c13790633.cfilter(c,tp,e)
	return c:IsFaceup() and c:IsControler(tp) and c:IsSetCard(0x1e71) and c:IsLocation(LOCATION_ONFIELD)
end
function c13790633.disop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not tg or not tg:IsExists(c13790624.cfilter,1,e:GetHandler(),tp,e) or not Duel.IsChainDisablable(ev) then return false end
	if e:GetHandler():GetFlagEffect(13790657)==0 and Duel.SelectYesNo(tp,aux.Stringid(13790624,3)) then
		e:GetHandler():RegisterFlagEffect(13790657,RESET_EVENT+0x1ec0000,0,1)
		Duel.NegateEffect(ev)
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	else end
end

function c13790633.spcon(e,tp)
	return Duel.IsExistingMatchingCard(c13790633.mafilter,tp,0,LOCATION_MZONE,1,nil)
end
function c13790633.mafilter(c)
	local atk=c:GetAttack()
	return c:IsFaceup() and not Duel.IsExistingMatchingCard(c13790633.cmafilter,tp,LOCATION_MZONE,0,1,nil,atk)
end
function c13790633.cmafilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>=atk and not Duel.IsExistingMatchingCard(c13790633.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c13790633.cfilter(c)
	return c:IsFaceup() and c:GetCode()==13790633
end
