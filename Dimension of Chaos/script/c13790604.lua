--Superheavy Samurai Nusutou
function c13790604.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c13790604.hspcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c13790604.hspcon2)
	e2:SetOperation(c13790604.hspop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13790604,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c13790604.cost)
	e3:SetTarget(c13790604.target)
	e3:SetOperation(c13790604.operation)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(13790604,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c13790604.cost)
	e4:SetTarget(c13790604.target2)
	e4:SetOperation(c13790604.operation2)
	c:RegisterEffect(e4)
end
function c13790604.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c13790604.hspcon(e,c)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c13790604.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c13790604.hspcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c13790604.hspop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c13790604.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c13790604.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x9a)
end

function c13790604.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c13790604.filter1(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)and c:GetSequence()<=5 and c:IsDestructable()
end
function c13790604.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(c13790604.filter1,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c13790604.filter1,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c13790604.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.SSet(tp,tc)
	end
end


function c13790604.filter2(c)
	return c:GetSequence()>5 and c:IsDestructable()
end
function c13790604.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(c13790604.filter2,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c13790604.filter2,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c13790604.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,6,POS_FACEUP,true)
		Duel.ChangePosition(tc,POS_FACEUP)
	end
end
