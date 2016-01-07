--Deskbot 009
function c13790838.initial_effect(c)
	--act-limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c13790838.aclimit)
	e1:SetCondition(c13790838.actcon)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c13790838.desreptg)
	e2:SetOperation(c13790838.desrepop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(85463083,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c13790838.atkcon)
	e3:SetTarget(c13790838.atktg)
	e3:SetOperation(c13790838.atkop)
	c:RegisterEffect(e3)
end
function c13790838.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xab) and c:GetCode()~=13790838
end
function c13790838.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c13790838.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c13790838.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13790838.filter,tp,LOCATION_MZONE,0,1,nil) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c13790838.antarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c13790838.antarget(e,c)
	return c~=e:GetHandler()
end
function c13790838.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=0
		local g=Duel.GetMatchingGroup(c13790838.filter,tp,LOCATION_MZONE,0,nil)
		local bc=g:GetFirst()
		while bc do
			atk=atk+bc:GetAttack()
			bc=g:GetNext()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY,2)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
	end
end

function c13790838.repfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xab) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c13790838.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c13790838.repfilter,tp,LOCATION_ONFIELD,0,1,c) end
	if Duel.SelectYesNo(tp,aux.Stringid(13790838,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c13790838.repfilter,tp,LOCATION_ONFIELD,0,1,1,c)
		e:SetLabelObject(g:GetFirst())
		Duel.HintSelection(g)
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c13790838.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end

function c13790838.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c13790838.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
