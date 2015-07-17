--Great Horn of Heaven
function c13790679.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c13790679.condition1)
	e1:SetTarget(c13790679.target1)
	e1:SetOperation(c13790679.activate1)
	c:RegisterEffect(e1)
end
function c13790679.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and Duel.GetTurnPlayer()~=tp and
	(Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c13790679.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c13790679.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
	if Duel.GetCurrentPhase()==PHASE_MAIN1 then
		Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_MAIN1,1)
	else
		Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_MAIN2,1)
	end
end
