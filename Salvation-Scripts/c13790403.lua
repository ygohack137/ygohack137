--Ritual Beast Ulti-Gaiapelio
function c13790403.initial_effect(c)
	c:EnableReviveLimit()
    --cannot spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c13790403.spcon)
	e2:SetOperation(c13790403.spop)
	c:RegisterEffect(e2)
end
function c13790403.spfilter1(c,code)
	return c:IsSetCard(0x10b5)
end
function c13790403.spfilter2(c,code)
	return c:IsSetCard(0x20b5)
end
function c13790403.spfilter3(c,code)
	return c:IsSetCard(0xb5) and c:IsType(TYPE_FUSION)
end
function c13790403.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.CheckReleaseGroup(tp,c13790403.spfilter1,1,nil)
		and Duel.CheckReleaseGroup(tp,c13790403.spfilter2,1,nil)
		and Duel.CheckReleaseGroup(tp,c13790403.spfilter3,1,nil)
end
function c13790403.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroup(tp,c13790403.spfilter1,1,1,nil)
	local g2=Duel.SelectReleaseGroup(tp,c13790403.spfilter2,1,1,nil)
	local g3=Duel.SelectReleaseGroup(tp,c13790403.spfilter3,1,1,nil)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
	
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c13790403.discon)
	e2:SetCost(c13790403.discost)
	e2:SetTarget(c13790403.distg)
	e2:SetOperation(c13790403.disop)
	c:RegisterEffect(e2)
end
function c13790403.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev) and not e:GetHandler():IsStatus(STATUS_CHAINING)
end

function c13790403.cfilter(c)
	return c:IsSetCard(0xb5) and c:IsAbleToRemoveAsCost()
end
function c13790403.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13790403.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13790403.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c13790403.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c13790403.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
