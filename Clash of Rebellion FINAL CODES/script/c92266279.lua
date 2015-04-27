--Moist Wind
function c92266279.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c92266279.target0)
	e1:SetOperation(c92266279.operation0)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92266279,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c92266279.cost1)
	e2:SetTarget(c92266279.target1)
	e2:SetOperation(c92266279.operation1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92266279,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c92266279.cost)
	e3:SetTarget(c92266279.target)
	e3:SetOperation(c92266279.operation)
	c:RegisterEffect(e3)

end
function c92266279.target0(e,tp,eg,ep,ev,re,r,rp,chk)
	local lp1=Duel.GetLP(tp)
	local lp2=Duel.GetLP(1-tp)
	e:SetLabel(5)
	if chk==0 then return true end
	if Duel.IsExistingMatchingCard(c92266279.filter,tp,LOCATION_DECK,0,1,nil) and Duel.CheckLPCost(tp,1000)
	and Duel.GetFlagEffect(tp,92266279)==0 and Duel.SelectYesNo(tp,aux.Stringid(92266279,0)) then e:SetLabel(0) end	
	if (lp1<lp2) and Duel.GetFlagEffect(tp,92266280)==0 and Duel.SelectYesNo(tp,aux.Stringid(92266279,1)) then e:SetLabel(1) end
	if e:GetLabel()==0 then Duel.RegisterFlagEffect(tp,92266279,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1) end
	if e:GetLabel()==1 then Duel.RegisterFlagEffect(tp,92266280,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1) end
end
function c92266279.operation0(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetLabel()==5 then return end
	local lp1=Duel.GetLP(tp)
	local lp2=Duel.GetLP(1-tp)
	local op=e:GetLabel()
	if op==0 then
	Duel.PayLPCost(tp,1000)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92266279.filter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
	if op==1 then
	Duel.Recover(tp,500,REASON_EFFECT)
	end
end
function c92266279.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) and Duel.GetFlagEffect(tp,92266279)==0 end
	Duel.PayLPCost(tp,1000)
	Duel.RegisterFlagEffect(tp,92266279,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c92266279.filter(c)
	return c:IsSetCard(0xc8) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c92266279.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92266279.filter,tp,LOCATION_DECK,0,1,nil) and Duel.GetFlagEffect(tp,92266279)==0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92266279.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92266279.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c92266279.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,92266280)==0 end
	Duel.RegisterFlagEffect(tp,92266280,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c92266279.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	local lp1=Duel.GetLP(tp)
	local lp2=Duel.GetLP(1-tp)
	if chk==0 then return lp1<lp2 and Duel.GetFlagEffect(tp,92266280)==0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c92266279.operation1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
