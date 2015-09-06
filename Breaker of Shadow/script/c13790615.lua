--Dragon's Bind
function c13790615.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13790615.target)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c13790615.sumlimit)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c13790615.descon2)
	e3:SetOperation(c13790615.desop2)
	c:RegisterEffect(e3)
end
function c13790615.filter(c)
	return c:GetBaseAttack()<=2500 and c:GetBaseDefence()<=2500 and c:GetRace()==RACE_DRAGON
end
function c13790615.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and c13790615.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13790615.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c13790615.filter,tp,LOCATION_MZONE,0,1,1,nil)
	c:SetCardTarget(g:GetFirst())
end
function c13790615.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return c:IsAttackBelow(tc:GetBaseAttack())
end

function c13790615.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c13790615.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
