--Houkai Karma
function c13701632.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13701632.target)
	e1:SetOperation(c13701632.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c13701632.condition)
	e2:SetCost(c13701632.cost)
	e2:SetOperation(c13701632.operation)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c13701632.thcost)
	e3:SetTarget(c13701632.thtg)
	e3:SetOperation(c13701632.thop)
	c:RegisterEffect(e3)
end
function c13701632.tgfilter(c,tp)
	return (not c:IsCode(13701611)) and c:IsFaceup() and c:IsSetCard(0xe3)
	 and Duel.IsExistingMatchingCard(c13701632.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,c)
end
function c13701632.cfilter(c,tc)
	return c:IsCode(13701611) and c:IsAbleToGrave()
end
function c13701632.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return true end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c13701632.tgfilter,tp,LOCATION_MZONE,0,1,nil,tp) and Duel.SelectYesNo(tp,aux.Stringid(85087012,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,c13701632.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	else
	end
end
function c13701632.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFirstTarget()==nil then return false end
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c13701632.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,3,nil,tp)
	if g:GetCount()>0 then
		if Duel.SendtoGrave(g,REASON_EFFECT)~=0 and tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(g:GetCount()*800)
			tc:RegisterEffect(e1)
		end
	elseif Duel.IsPlayerCanDiscardDeck(tp,1) then
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleDeck(tp)
	end
end

function c13701632.cfilter(c,tp)
	return c:IsCode(13701611) and c:IsControler(tp)
end
function c13701632.condition(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return rc and rc:IsSetCard(0xe3) and eg:IsExists(c13701632.cfilter,1,nil,tp) and Duel.GetTurnPlayer()~=tp
end
function c13701632.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c13701632.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,Duel.GetLP(tp)/2)
end

function c13701632.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c13701632.thfilter(c)
	return c:IsSetCard(0xe3) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c13701632.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13701632.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13701632.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13701632.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
