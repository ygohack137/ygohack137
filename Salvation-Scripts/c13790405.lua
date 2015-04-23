--Bloom Diva the Floral Melodious Saint
function c13790405.initial_effect(c)
	--fusion material
	aux.AddFusionProcFun2(c,c13790405.ffilter2,c13790405.ffilter1,true)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e0:SetValue(1)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_BATTLED)
	e3:SetOperation(c13790405.batop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(31764700,0))
	e4:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetTarget(c13790405.damtg)
	e4:SetOperation(c13790405.damop)
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4)
end
function c13790405.ffilter1(c)
	return c:IsSetCard(0x9b)
end
function c13790405.ffilter2(c)
	return c:IsCode(3395226) or c:IsCode(5908650) or c:IsCode(13790421)
end
function c13790405.batop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bit.band(bc:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL then
		e:SetLabelObject(bc)
	else
		e:SetLabelObject(nil)
	end
end
function c13790405.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if not e:GetHandler():IsRelateToBattle() then return false end
	local bc=e:GetLabelObject():GetLabelObject()
	if chk==0 then return bc end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabelObject():GetLabel())
	if bc:IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
	end
end
function c13790405.damop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject():GetLabelObject()
	local atk1=bc:GetBaseAttack()
	local atk2=e:GetHandler():GetBaseAttack()
	local dam=math.abs(atk1-atk2)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
