--Dinomist Brachion
function c13790633.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13790624,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c13790633.negcon)
	e2:SetTarget(c13790633.negtg)
	e2:SetOperation(c13790633.negop)
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

function c13790633.tfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1e71) and c:IsControler(tp)
end
function c13790633.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c13790633.tfilter,1,nil)and g:GetFirst()~=e:GetHandler() and Duel.IsChainDisablable(ev)
end
function c13790633.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c13790633.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end


function c13790633.cfilter(c)
	return c:IsFaceup() and c:GetCode()==13790633
end
function c13790633.mafilter(c)
	local atk=c:GetAttack()
	return c:IsFaceup() and not Duel.IsExistingMatchingCard(c13790633.cmafilter,c:GetControler(),0,LOCATION_MZONE,1,nil,atk)
end
function c13790633.cmafilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>=atk
end
function c13790633.spcon(e,c)
	if c==nil then return true end
	return Duel.IsExistingMatchingCard(c13790633.mafilter,c:GetControler(),0,LOCATION_MZONE,1,nil)
		and not Duel.IsExistingMatchingCard(c13790633.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
