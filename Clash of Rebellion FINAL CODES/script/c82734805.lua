--Infernoid Terra
function c82734805.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c82734805.fscon)
	e1:SetOperation(c82734805.fsop)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c82734805.matcheck)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c82734805.regcon)
	e3:SetOperation(c82734805.regop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c82734805.matcheck(e,c)
	local g=c:GetMaterial()
	e:SetLabel(g:GetClassCount(Card.GetCode))
end
function c82734805.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c82734805.mfilter1(c,mg)
	return c:IsCode(14799437) and mg:IsExists(Card.IsSetCard,1,c,0xbb)
end
function c82734805.mfilter2(c,mg)
	return c:IsCode(23440231) and mg:IsExists(Card.IsCode,1,c,14799437)
end
function c82734805.mfilter3(c,mg)
	return c:IsSetCard(0xbb) and not (c:IsCode(14799437) or c:IsCode(23440231))
end
function c82734805.fscon(e,mg,gc)
	if mg==nil then return false end
	if gc then return false end
	return mg:IsExists(c82734805.mfilter1,1,nil,mg)
end
function c82734805.fsop(e,tp,eg,ep,ev,re,r,rp,gc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:FilterSelect(tp,c82734805.mfilter1,1,1,nil,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=eg:FilterSelect(tp,c82734805.mfilter2,1,1,nil,eg)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g3=eg:FilterSelect(tp,c82734805.mfilter3,1,10,nil)
	g1:Merge(g3)
	Duel.SetFusionMaterial(g1)
end


function c82734805.regcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c82734805.regop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	local c=e:GetHandler()
	if ct>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_EXTRA,0,3,3,nil)
		local tg=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
			local g2=tg:Select(1-tp,3,3,nil)
			g1:Merge(g2)
			if g1:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SendtoGrave(g1,REASON_EFFECT)
		end
	end
	if ct>=5 then
		Duel.DiscardDeck(0,3,REASON_EFFECT)
		Duel.DiscardDeck(1,3,REASON_EFFECT)
	end
	if ct>=8 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_REMOVED,0,1,3,nil)
		local tg=Duel.GetFieldGroup(tp,0,LOCATION_REMOVED)
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
			local g2=tg:Select(1-tp,1,3,nil)
			g1:Merge(g2)
			if g1:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SendtoGrave(g1,REASON_EFFECT+REASON_RETURN)
		end
	end
	if ct>=10 then
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	if g:GetCount()>0 then Duel.SendtoGrave(g,REASON_DISCARD+REASON_EFFECT) end
	end
end
