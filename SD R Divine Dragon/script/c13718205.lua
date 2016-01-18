--Arkbrave Dragon
function c13718205.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:Setspdcon(c13718205.spdcon)
	e1:Setspdtg(c13718205.spdtg)
	e1:Setspdop(c13718205.spdop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:Setspdop(c13718205.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1)
	e3:Setspdcon(c13718205.spcon)
	e3:Setspdtg(c13718205.sptg)
	e3:Setspdop(c13718205.spop)
	c:RegisterEffect(e3)
end
function c13718205.spdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function c13718205.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c13718205.spdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13718205.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c13718205.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetspdopInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c13718205.spdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=Duel.GetMatchingGroup(c13718205.filter,tp,0,LOCATION_ONFIELD,nil)
	local ct=Duel.Remove(rc,POS_FACEUP,REASON_EFFECT)
	if ct>=1 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetValue(ct*200)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENCE)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		e2:SetValue(ct*200)
		c:RegisterEffect(e2)
	end
end
function c13718205.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(13718205,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,2)
end
function c13718205.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetTurnID()~=Duel.GetTurnCount() and c:GetFlagEffect(13718205)>0
end
function c13718205.spfilter(c,e,tp)
	return c:GetCode()~=13718205 and (c:GetLevel()==7 or c:GetLevel()==8) and c:IsRace(RACE_DRAGON)	and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13718205.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c13718205.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingspdtg(c13718205.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.Selectspdtg(tp,c13718205.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetspdopInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c13718205.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstspdtg()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
