//
//		OFFICIAL ZE_SANTASSINATION_V3 STRIPPER SOLUTION
//		UPDATED: 2019-06-16
//		CONTACT: https://steamcommunity.com/id/LuffarenPer/
//
//============================================================================\\
//	[PROBLEM]
// only a certain amount of item-hits are actually registered to the bosses
//
//	[SOLUTION]
// this script-solution will ensure that hits are always registered
// this script will also prevent triggering a double-hit as well
//
//	[NOTE]
// since the bosses will take full damage from items now, the values have been lowered
// this is to prevent the bosses from dying way too fast
// it should still serve as a vast improvement
// and when it *does* hit by the OG-trigger, it will deal full damage
// so instead of hits of 	[0, 0, 0, 375, 0, 375, 0, 0]
// it would deal like this: [150, 150, 150, 375, 150, 375, 150, 150]
// you could basically see the "true" hits as some form of "crit" damage i guess
//----------------------------------------------------------------------------\\
//DO NOT ALTER THESE VALUES, if something seems off, contact me (Luffaren):
//>>>>>		https://steamcommunity.com/id/LuffarenPer/
//----------------------------------------------------------------------------\\
DAMAGE_MINIGUN <- 5;		//the actual trigger would damage 125
DAMAGE_BEAM <- 50;			//the actual trigger would damage 375
DAMAGE_EXPLOSION <- 300;	//the actual trigger would damage 500
//============================================================================\\
bossfight <- false;
bosstarget <- null;
bossindex <- 0;
function SetBossTarget(index)
{
	bossfight = true;
	bossindex = index;
	if(index==1)
		bosstarget = Entities.FindByName(null,"bosss_hp");
	else if(index==2)
		bosstarget = Entities.FindByName(null,"bosss_hp1");
	else if(index==3)
		bosstarget = Entities.FindByName(null,"bosss_hp2");
}
function ClearBossTarget()
{
	bossfight = false;
	bosstarget = null;
	bossindex = 0;
}

minigun_hit <- null;
function Used_Minigun()
{
	if(!bossfight)return;
	if(minigun_hit==null||!minigun_hit.IsValid())
	{
		print("MINIGUN - MISS (actual trigger), calculating manually..........");
		if(bosstarget!=null&&bosstarget.IsValid())
		{
			local bosshit = null;
			if(bossindex==1)bosshit = IsItemHitting(caller,6,100);
			else if(bossindex==2)bosshit = IsItemHitting(caller,10,90);
			else if(bossindex==3)bosshit = IsItemHitting(caller,15,300);
			if(bosshit)
			{
				EntFireByHandle(bosstarget,"RemoveHealth",DAMAGE_MINIGUN.tostring(),0.00,null,null);
				printl("HIT");
			}
			else printl("MISS");
		}
		else printl("MISS");
	}
	else printl("MINIGUN - HIT (actual trigger)");
	minigun_hit = null;
}
function Hit_Minigun()
{
	if(!bossfight)return;
	if(activator==null||!activator.IsValid())return;
	if(activator.GetClassname()=="func_physbox_multiplayer")
	{if(activator.GetName()=="bosss_hp"||activator.GetName()=="bosss_hp1"||activator.GetName()=="bosss_hp2")
		minigun_hit = activator;}
}

beam_hit <- null;
function Used_Beam()
{
	if(!bossfight)return;
	if(beam_hit==null||!beam_hit.IsValid())
	{
		print("BEAM - MISS (actual trigger), calculating manually..........");
		if(bosstarget!=null&&bosstarget.IsValid())
		{
			local bosshit = null;
			if(bossindex==1)bosshit = IsItemHitting(caller,6,100);
			else if(bossindex==2)bosshit = IsItemHitting(caller,10,90);
			else if(bossindex==3)bosshit = IsItemHitting(caller,15,300);
			if(bosshit)
			{
				EntFireByHandle(bosstarget,"RemoveHealth",DAMAGE_BEAM.tostring(),0.00,null,null);
				printl("HIT");
			}
			else printl("MISS");
		}
		else printl("MISS");
	}
	else printl("BEAM - HIT (actual trigger)");
	beam_hit = null;
}
function Hit_Beam()
{
	if(!bossfight)return;
	if(activator==null||!activator.IsValid())return;
	if(activator.GetClassname()=="func_physbox_multiplayer")
	{if(activator.GetName()=="bosss_hp"||activator.GetName()=="bosss_hp1"||activator.GetName()=="bosss_hp2")
		beam_hit = activator;}
}

explosion_hit <- null;
function Used_Explosion()
{
	if(!bossfight)return;
	if(explosion_hit==null||!explosion_hit.IsValid())
	{
		print("EXPLOSION - MISS (actual trigger), calculating manually..........");
		if(bosstarget!=null&&bosstarget.IsValid())
		{
			local bosshit = false;
			if(bossindex==1 && GetDistance(caller.GetOrigin(),bosstarget.GetOrigin()) <= (300+100))bosshit = true;
			else if(bossindex==2 && GetDistance(caller.GetOrigin(),bosstarget.GetOrigin()) <= (300+100))bosshit = true;
			else if(bossindex==3 && GetDistance(caller.GetOrigin(),bosstarget.GetOrigin()) <= (300+400))bosshit = true;
			if(bosshit)
			{
				EntFireByHandle(bosstarget,"RemoveHealth",DAMAGE_EXPLOSION.tostring(),0.00,null,null);
				printl("HIT");
			}
			else printl("MISS");
		}
		else printl("MISS");
	}
	else printl("EXPLOSION - HIT (actual trigger)");
	explosion_hit = null;
}
function Hit_Explosion()
{
	if(!bossfight)return;
	if(activator==null||!activator.IsValid())return;
	if(activator.GetClassname()=="func_physbox_multiplayer")
	{if(activator.GetName()=="bosss_hp"||activator.GetName()=="bosss_hp1"||activator.GetName()=="bosss_hp2")
		explosion_hit = activator;}
}

function GetDistance(v1,v2){return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));}
function GetTargetYaw(start,target)
{
	local yaw = 0.00;
	local v = Vector(start.x-target.x,start.y-target.y,start.z-target.z);
	local vl = sqrt(v.x*v.x+v.y*v.y);
	yaw = 180*acos(v.x/vl)/3.14159;
	yaw-=180;if(v.y<0)yaw=-yaw;return yaw;
}
function IsItemHitting(itemhandle,angularlimit,zheight)
{
	if(itemhandle==null||!itemhandle.IsValid||bosstarget==null||!bosstarget.IsValid())return false;
	if(abs(itemhandle.GetOrigin().z-bosstarget.GetOrigin().z)>zheight)return false;
	local angdif = GetTargetYaw(itemhandle.GetOrigin(),bosstarget.GetOrigin()) - itemhandle.GetAngles().y;
	if(angdif>=0.00&&angdif<angularlimit||angdif<0.00&&angdif>(-angularlimit))return true;
	if(angdif<= -360&&angdif>(-360 + (-angularlimit))||angdif> -360&&angdif< (-360 + (angularlimit)))return true;
	return false;
}

function SetItemFilter()
{
	caller.ValidateScriptScope();
	local sc = caller.GetScriptScope();
	if("itemowner" in sc)
		sc.itemowner = activator;
	else
		sc.itemowner <- activator;
	//printl("ITEM-SET: " + caller + "    |     "+activator);
}
function CheckItemFilter()
{
	caller.ValidateScriptScope();
	local sc = caller.GetScriptScope();
	if("itemowner" in sc)
	{
		if(activator==sc.itemowner)
			EntFireByHandle(caller,"FireUser1","",0.00,activator,activator);
	}
	//printl("ITEM-CHECK: " + caller + "    |     "+activator);
}
