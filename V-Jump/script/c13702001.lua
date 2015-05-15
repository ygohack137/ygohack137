--Red-Eyes Tracer Dragon
function c13702001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c13702001.condition)
	e1:SetTarget(c13702001.target)
	e1:SetOperation(c13702001.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c13702001.sumcost)
	e2:SetOperation(c13702001.sumop)
	c:RegisterEffect(e2)
end
function c13702001.cfilter(c,tp)
	return (c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT) or (c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE)) and Duel.GetTurnPlayer()~=tp)
	 and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and c:IsPreviousPosition(POS_FACEUP) and c:IsLevelBelow(7)
		and c:IsSetCard(0x3b)
end
function c13702001.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13702001.cfilter,1,nil,tp) and  not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c13702001.spfilter(c,e,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsLevelBelow(7) and c:IsSetCard(0x3b) and c:IsControler(tp) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13702001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ct=eg:FilterCount(c13702001.spfilter,nil,e,tp)
		return ct>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
	end
	Duel.SetTargetCard(eg)
	local g=eg:Filter(c13702001.spfilter,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c13702001.spfilter2(c,e,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13702001.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local sg=eg:Filter(c13702001.spfilter2,nil,e,tp)
		if ft<sg:GetCount() then return end
		local ct=Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c13702001.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c13702001.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,13702001)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x3b))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,13702001,RESET_PHASE+PHASE_END,0,1)
end

