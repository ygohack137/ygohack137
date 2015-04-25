--Giant Weasel Explosion
function c31044787.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c31044787.condition)
	e1:SetOperation(c31044787.activate)
	c:RegisterEffect(e1)
end
function c31044787.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	return Duel.GetLP(tp)<g:GetSum(Card.GetAttack)
end
function c31044787.filter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk)
end
function c31044787.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local lp=Duel.GetLP(tp)
	local atk=g:GetSum(Card.GetAttack)
		while  lp<atk do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g2=Duel.SelectMatchingCard(1-tp,Card.IsAbleToDeck,1-tp,LOCATION_MZONE,0,1,1,nil)
			local sc=g2:GetFirst()
			Duel.SendtoDeck(sc,nil,2,REASON_EFFECT)
			atk=atk-sc:GetAttack()
	end
end
