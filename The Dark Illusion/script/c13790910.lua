--Dark Magic Circle
function c13790910.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,137909101)
	e1:SetOperation(c13790910.activate)
	c:RegisterEffect(e1)
	--change pos
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,137909102)
	e2:SetCondition(c13790910.spcon)
	e2:SetTarget(c13790910.sptg)
	e2:SetOperation(c13790910.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c13790910.filter(c)
	return c:IsAbleToHand() 
	and (c:GetCode()==1784686 or c:GetCode()==99789342 or c:GetCode()==2314238 or c:GetCode()==69542930 or c:GetCode()==87210505 
	or c:GetCode()==13604200 or c:GetCode()==63391643 or c:GetCode()==67227834 or c:GetCode()==75190122 or c:GetCode()==48680970
	 or c:GetCode()==68334074 or c:GetCode()==13790911 or c:GetCode()==13790912 or c:GetCode()==13790910 or c:GetCode()==46986414)
end
function c13790910.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(c13790910.filter,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(13790910,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,c13790910.filter,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		Duel.SortDecktop(tp,tp,2)
	else Duel.SortDecktop(tp,tp,3) end
end

function c13790910.cfilter(c,tp)
	return c:IsFaceup() and c:GetCode()==46986414 and c:IsControler(tp)
end
function c13790910.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13790910.cfilter,1,nil,tp)
end
function c13790910.filter2(c)
	return c:IsAbleToRemove()
end
function c13790910.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c13790910.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13790910.filter2,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c13790910.filter2,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c13790910.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
