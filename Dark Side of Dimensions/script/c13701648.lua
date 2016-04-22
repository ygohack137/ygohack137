--Dragon's Perseverance
function c13701648.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c13701648.con)
	e1:SetTarget(c13701648.tg)
	e1:SetOperation(c13701648.op)
	c:RegisterEffect(e1)
	if not c13701648.global_check then
		c13701648.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c13701648.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end

function c13701648.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:GetFlagEffect(13701648)==0 then
			tc:RegisterFlagEffect(13701648,RESET_PHASE+PHASE_END,0,1)
		end
		tc=eg:GetNext()
	end
end

function c13701648.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP() or Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c13701648.fil1(c)
  return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:GetFlagEffect(13701648)>0
end
function c13701648.fil2(c)
  return c:GetFlagEffect(13701648)>0
end
function c13701648.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c13701648.fil1(chkc) end
  if chk==0 then return Duel.IsExistingTarget(c13701648.fil1,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c13701648.fil2,tp,0,LOCATION_MZONE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  Duel.SelectTarget(tp,c13701648.fil1,tp,LOCATION_MZONE,0,1,1,nil)
end
function c13701648.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if not tc:IsRelateToEffect(e) then return end
  local mc=Duel.GetMatchingGroupCount(c13701648.fil2,tp,0,LOCATION_MZONE,nil)
  if mc>0 then
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(mc)
		tc:RegisterEffect(e1)
	end
end
