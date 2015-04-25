--Black Dragon Archfiend
function c45349196.initial_effect(c)
	c:SetSPSummonOnce(45349196)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c45349196.ffilter1,c45349196.ffilter2,true)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c45349196.aclimit)
	e1:SetCondition(c45349196.actcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c45349196.descon)
	e2:SetTarget(c45349196.destg)
	e2:SetOperation(c45349196.desop)
	c:RegisterEffect(e2)
end
function c45349196.ffilter1(c)
	return c:IsSetCard(0x45) and c:IsType(TYPE_NORMAL) and c:GetLevel()==6
end
function c45349196.ffilter2(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_NORMAL)
end
function c45349196.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c45349196.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end

function c45349196.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
end
function c45349196.filter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_NORMAL)
end
function c45349196.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c45349196.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c45349196.filter,tp,LOCATION_GRAVE,0,1,nil)
	 and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c45349196.filter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c45349196.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end
