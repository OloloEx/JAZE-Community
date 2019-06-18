#include <sdktools>

public Plugin myinfo =
{
	name = "Button Finder",
	author = "Walderr",
	description = "Позволяет находить Hammer ID кнопок",
	version = "1.0",
	url = "http://jaze.ru/"
};

public OnPluginStart()
{
	RegConsoleCmd("sm_findbutton", Command_FindButton);
}

public Action Command_FindButton(int client, int args)
{
	int id = GetClientAimTarget(client, false);
	
	if(id == -1)
	{
		PrintHintText(client, "Объект не найден!");
		return Plugin_Handled;
	}
	
	char class[MAX_NAME_LENGTH];
	GetEdictClassname(id, class, sizeof(class));
	
	if(!StrEqual(class, "func_button"))
	{
		PrintHintText(client, "Кнопка не найдена!");
		return Plugin_Handled;
	}
	
	char name[MAX_NAME_LENGTH];
	GetEntPropString(id, Prop_Data, "m_iName", name, sizeof(name));
	
	if(StrEqual(name, "")) FormatEx(name, sizeof(name), "Не найдено");
	
	int hid = GetEntProp(id, Prop_Data, "m_iHammerID");
	
	PrintCenterText(client, "Имя: %s\nHammer ID: %i", name, hid);
	
	return Plugin_Handled;
}
