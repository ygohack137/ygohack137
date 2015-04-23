--暗躍のドルイド・ウィド
function c97074649.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(97074649,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c97074649.setcon)
	e1:SetCost(c97074649.setcost)
	e1:SetTarget(c97074649.settg)
	e1:SetOperation(c97074649.setop)
	c:RegisterEffect(e1)
end
function c97074649.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c97074649.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,97074649)==0 end
	Duel.RegisterFlagEffect(tp,97074649,RESET_PHASE+PHASE_END,0,1)
end
function c97074649.filter(c)
	return c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS and c:IsSSetable()
end
function c97074649.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c97074649.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c97074649.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	Duel.SelectTarget(tp,c97074649.filter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c97074649.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsSSetable() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.SSet(tp,tc)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end