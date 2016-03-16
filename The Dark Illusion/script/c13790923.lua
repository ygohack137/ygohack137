--Spell Strider
function c13790923.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c13790923.sptg)
	e1:SetOperation(c13790923.spop)
	c:RegisterEffect(e1)
end
function c13790923.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL) and c:IsAbleToRemove()
end
function c13790923.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
	and Duel.IsExistingTarget(c13790923.filter,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingTarget(c13790923.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g1=Duel.SelectTarget(tp,c13790923.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	local g2=Duel.SelectTarget(tp,c13790923.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13790923.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 and Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>1 then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
