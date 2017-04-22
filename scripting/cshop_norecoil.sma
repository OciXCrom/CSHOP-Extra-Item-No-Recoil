#include <amxmodx>
#include <customshop>
#include <fakemeta>

#define PLUGIN_VERSION "4.x"

additem ITEM_NORECOIL
new bool:g_bNoRecoil[33]

public plugin_init()
{
    register_plugin("CSHOP: No Recoil", PLUGIN_VERSION, "OciXCrom")
    register_forward(FM_PlayerPreThink, "PreThink")
}

public plugin_precache()
    ITEM_NORECOIL = cshop_register_item("norecoil", "No Recoil", 12000, 1)

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
    
public PreThink(id)
{
    if(is_user_alive(id) && g_bNoRecoil[id])
        set_pev(id, pev_punchangle, {0.0, 0.0, 0.0}) 
}