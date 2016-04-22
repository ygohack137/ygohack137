--Neo Blue-Eyes Ultimate Dragon
function c13701606.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,89631139,3,true,true)
	--chain attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCountLimit(2)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c13701606.atcon)
	e1:SetCost(c13701606.atcost)
	e1:SetOperation(c13701606.atop)
	c:RegisterEffect(e1)
end
function c13701606.cfilter(c)
	return c:IsFaceup()
end
function c13701606.atcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		and not Duel.IsExistingMatchingCard(c13701606.cfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c13701606.filter(c)
	return c:IsSetCard(0xdd) and c:IsType(TYPE_FUSION)
end
function c13701606.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13701606.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c13701606.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c13701606.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToBattle() then return end
	Duel.ChainAttack()
end
