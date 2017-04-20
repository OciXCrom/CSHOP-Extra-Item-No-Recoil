#include <amxmodx>
#include <customshop>
#include <fakemeta>

#define PLUGIN_VERSION "1.1"

additem ITEM_NORECOIL
#define NORECOIL_ID "norecoil"
#define NORECOIL_NAME "No Recoil"
#define NORECOIL_PRICE 12000
#define NORECOIL_LIMIT 1
new bool:g_blNoRecoil[33]

public plugin_init()
{
	register_plugin("Custom Shop: No Recoil", PLUGIN_VERSION, "OciXCrom")
	register_forward(FM_PlayerPreThink, "fwdPreThink")
}

public plugin_precache()
	ITEM_NORECOIL = cshopRegisterItem(NORECOIL_ID, NORECOIL_NAME, NORECOIL_PRICE, NORECOIL_LIMIT)

public cshopItemBought(id, iItem)
	if(iItem == ITEM_NORECOIL) 			{ g_blNoRecoil[id] = true; }
	
public cshopItemRemoved(id, iItem)
	if(iItem == ITEM_NORECOIL) 			{ g_blNoRecoil[id] = false; }
	
public fwdPreThink(id)
	if(is_user_alive(id) && g_blNoRecoil[id])
		set_pev(id, pev_punchangle, {0.0, 0.0, 0.0})