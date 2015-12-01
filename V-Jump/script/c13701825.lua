--Number 77: The Seven Sins
function c13701825.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,2,c13701825.ovfilter,aux.Stringid(13701825,0),2,c13701825.xyzop)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetDescription(aux.Stringid(13701825,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c13701825.condition)
	e1:SetCost(c13701825.cost)
	e1:SetTarget(c13701825.target)
	e1:SetOperation(c13701825.operation)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c13701825.reptg)
	c:RegisterEffect(e2)
end
function c13701825.ovfilter(c)
	local rk=c:GetRank()
	return c:IsFaceup() and (rk==10 or rk==11)
end
function c13701825.xyzop(e,tp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(13701825,RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END,0,1)
end
function c13701825.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(tp)>10 and e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c13701825.filter(c)
	return c:IsAbleToRemove() and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c13701825.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c13701825.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c13701825.filter,tp,0,LOCATION_MZONE,1,nil) 
	and e:GetHandler():GetFlagEffect(13701825)==0 end
	local sg=Duel.GetMatchingGroup(c13701825.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end
function c13701825.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c13701825.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	local ct=Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_REMOVED)
	if ct>0 then
		Duel.BreakEffect()
		local xyz=ct:Select(tp,1,1,nil):GetFirst()
		Duel.Overlay(c,Group.FromCards(xyz))
	end
end

function c13701825.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(13701825,1)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
