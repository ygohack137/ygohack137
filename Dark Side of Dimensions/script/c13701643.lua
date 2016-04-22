--Dimension Reflector
function c13701643.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c13701643.cost)
	e1:SetTarget(c13701643.target)
	e1:SetOperation(c13701643.activate)
	c:RegisterEffect(e1)
end
function c13701643.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE,0,2,2,nil)
	Duel.Remove(cg,POS_FACEUP,REASON_COST)
end
function c13701643.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
		Duel.IsPlayerCanSpecialSummonMonster(tp,13701643,0,0x21,0,0,4,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13701643.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,13701643,0,0x21,tc:GetAttack(),tc:GetDefence(),4,RACE_SPELLCASTER,ATTRIBUTE_DARK) then return end
	c:AddTrapMonsterAttribute(TYPE_EFFECT,ATTRIBUTE_DARK,RACE_SPELLCASTER,4,tc:GetAttack(),tc:GetDefence())
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	c:TrapMonsterBlock()
	Duel.Damage(1-tp,c:GetAttack(),REASON_EFFECT)
end
