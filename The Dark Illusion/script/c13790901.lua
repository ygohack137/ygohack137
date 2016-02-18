--Metalphosis Cardinal
function c13790901.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunFunRep(c,c13790901.mfilter1,c13790901.mfilter2,2,2,true)

end
function c13790901.mfilter1(c)
	return c:IsFusionSetCard(0x1371)
end
function c13790901.mfilter2(c)
	return c:GetAttack()<=3000
end
