--Machine Angel Ritual
function c13703012.initial_effect(c)
	aux.AddRitualProcGreater(c,c13703012.ritual_filter)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetTarget(c13703012.reptg)
	e3:SetValue(c13703012.repval)
	e3:SetOperation(c13703012.repop)
	c:RegisterEffect(e3)
end
function c13703012.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsSetCard(0x1373) 
end

function c13703012.repfilter(c,tp)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsAttribute(ATTRIBUTE_LIGHT)
		and (c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()~=tp))
end
function c13703012.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c13703012.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(13703012,0))
end
function c13703012.repval(e,c)
	return c13703012.repfilter(c,e:GetHandlerPlayer())
end
function c13703012.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
