--Swaying Gaze
function c222701.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c222701.target)
	e1:SetOperation(c222701.activate)
	c:RegisterEffect(e1)
end
function c222701.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_PENDULUM) and c:IsDestructable()
end
function c222701.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c222701.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c222701.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c222701.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c222701.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	local count=Duel.Destroy(sg,REASON_EFFECT)
	if count>=1 then
		Duel.Damage(1-tp,500,REASON_EFFECT)
	end
	if count>=2 then
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,1,1,nil,TYPE_PENDULUM)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	end
	if count>=3 then
	local g=Duel.SelectMatchingCard(tp,IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
	end
	if count>=4 then
		local th=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,nil,222701)
		if th then
			Duel.SendtoHand(th,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,th)
		end
	end
end
