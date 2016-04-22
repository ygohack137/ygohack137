--Counter Gate
function c13701639.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c13701639.condition)
	e1:SetTarget(c13701639.target)
	e1:SetOperation(c13701639.activate)
	c:RegisterEffect(e1)
end
function c13701639.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()==nil
end
function c13701639.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c13701639.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	Duel.BreakEffect()
	if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	local dr=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,dr)
	Duel.BreakEffect()
	if dr:IsType(TYPE_MONSTER) and dr:IsSummonable(true,nil) and Duel.SelectYesNo(tp,aux.Stringid(13701639,0)) then
		if Duel.Summon(tp,dr,true,nil)==0 then
			Duel.ShuffleHand(tp)
		end
	else Duel.ShuffleHand(tp) end
end
