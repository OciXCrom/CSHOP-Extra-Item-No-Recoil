#include <amxmodx>
#include <customshop>
#include <fakemeta>
#include <hamsandwich>

#define PLUGIN_VERSION "4.x"
#define EXCLUDED_WEAPONS (1<<2 | 1<<CSW_KNIFE | 1<<CSW_HEGRENADE | 1<<CSW_FLASHBANG | 1<<CSW_SMOKEGRENADE | 1<<CSW_C4)

additem ITEM_NORECOIL
new bool:g_bNoRecoil[33]

public plugin_init()
{
	register_plugin("CSHOP: No Recoil", PLUGIN_VERSION, "OciXCrom")
	
	new szWeapon[18]
	
	for(new i = CSW_P228; i <= CSW_P90; i++)
	{
		if(!(EXCLUDED_WEAPONS & (1<<i)) && get_weaponname(i, szWeapon, charsmax(szWeapon))) 
			RegisterHam(Ham_Weapon_PrimaryAttack, szWeapon, "OnPrimaryAttack", 1)
	}
}
  
public plugin_precache()
	ITEM_NORECOIL = cshop_register_item("norecoil", "No Recoil", 12000, 1)
	
public client_putinserver(id)
	g_bNoRecoil[id] = false

public cshop_item_selected(id, iItem)
{
	if(iItem == ITEM_NORECOIL)
		g_bNoRecoil[id] = true
}
	
public cshop_item_removed(id, iItem)
{
	if(iItem == ITEM_NORECOIL)
		g_bNoRecoil[id] = false
}

public OnPrimaryAttack(iEnt)
{
	static id
	id = pev(iEnt, pev_owner)
	
	if(g_bNoRecoil[id])
		set_pev(id, pev_punchangle, {0.0, 0.0, 0.0})
}