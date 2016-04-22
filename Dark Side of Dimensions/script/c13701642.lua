--Final Geas
function c13701642.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMING_DESTROY+TIMING_END_PHASE)
	e1:SetCondition(c13701642.condition)
	e1:SetTarget(c13701642.target)
	e1:SetOperation(c13701642.activate)
	c:RegisterEffect(e1)
	if not c13701642.globle_check then
		c13701642.globle_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c13701642.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c13701642.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p1=false
	local p2=false
	while tc do
		if tc:GetLevel()>6 then
			if tc:GetPreviousControler()==tp then p1=true else p2=true end
		end
		tc=eg:GetNext()
	end
	if p1 then Duel.RegisterFlagEffect(tp,137016421,RESET_PHASE+PHASE_END,0,1) end
	if p2 then Duel.RegisterFlagEffect(tp,137016422,RESET_PHASE+PHASE_END,0,1) end
end
function c13701642.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,137016421)~=0 and Duel.GetFlagEffect(tp,137016422)~=0
end

function c13701642.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c13701642.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13701642.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	local sg=Duel.GetMatchingGroup(c13701642.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end
function c13701642.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c13701642.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	local og=Duel.GetOperatedGroup():Filter(Card.IsLocation,nil,LOCATION_REMOVED):Filter(Card.IsRace,nil,RACE_SPELLCASTER):GetMaxGroup(Card.GetLevel)
	if og:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(13701642,0)) then
			local sg=og:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
