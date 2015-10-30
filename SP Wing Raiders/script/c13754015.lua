--Super Quantum Fairy Alphan
function c13754015.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13754015,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c13754015.target)
	e1:SetOperation(c13754015.activate)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13754015,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,3754015)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c13754015.cost)
	e2:SetTarget(c13754015.thtg)
	e2:SetOperation(c13754015.thop)
	c:RegisterEffect(e2)
end
function c13754015.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x1e72) and c:GetLevel()>0
end
function c13754015.filter2(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c13754015.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c13754015.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13754015.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c13754015.filter2,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c13754015.filter1,tp,LOCATION_MZONE,0,1,1,nil)
end
function c13754015.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local g=Duel.GetMatchingGroup(c13754015.filter2,tp,LOCATION_MZONE,0,tc)
		local lc=g:GetFirst()
		local lv=tc:GetLevel()
		while lc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
			e1:SetValue(lv)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			lc:RegisterEffect(e1)
			lc=g:GetNext()
		end
	end
end

function c13754015.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c13754015.thfilter(c,e,tp)
	return c:IsSetCard(0x1e72) and c:IsType(TYPE_MONSTER)
end
function c13754015.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13754015.thfilter,tp,LOCATION_DECK,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c13754015.thop(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetMatchingGroup(c13754015.thfilter,tp,LOCATION_DECK,0,nil,e,tp)
		if g:GetCount()<=2 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g2=g:Select(tp,1,1,nil)
			g:Remove(Card.IsCode,nil,g2:GetFirst():GetCode())
			g1:Merge(g2)
			if g:GetCount()>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local g3=g:Select(tp,1,1,nil)
				g1:Merge(g3)
			end
		end
		local tc=g1:RandomSelect(1-tp,1)
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		g1:RemoveCard(tc:GetFirst())
		Duel.SendtoGrave(g1,REASON_EFFECT)
end
