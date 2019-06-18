#include <sdktools>

public Plugin myinfo =
{
	name = "Boss Health Finder",
	author = "Walderr",
	description = "Плагин для создания конфигов здоровья боссов",
	version = "1.0",
	url = "http://jaze.ru/"
};

public void OnPluginStart(){RegConsoleCmd("sm_findcounters", Command_FindCounters);}
public void OnMapStart(){HookEntityOutput("math_counter", "OutValue", OutValue);}
public void OnMapEnd(){UnhookEntityOutput("math_counter", "OutValue", OutValue);}

public Action Command_FindCounters(int client, int args)
{
	int index;
	PrintToChat(client, " \x07--------Счётчики:--------");
	
	while((index = FindEntityByClassname(index, "math_counter")) != -1) 
	{
		char strName[64];
		GetEntPropString(index, Prop_Data, "m_iName", strName, sizeof(strName));
		
		int offset = FindDataMapInfo(index, "m_OutValue");
		float value = GetEntDataFloat(index, offset);
		int intValue = RoundToZero(value);
		
		PrintToChat(client, " \x0BИмя:\x04 %s,\x0B Значение:\x04 %i", strName, intValue);
	}
	
	PrintToChat(client, " \x07----------------------------");
	return Plugin_Handled;
}

public void OutValue(char[] output, int caller, int activator, float Any)
{
	char BossCounterName[128];
	GetEntPropString(caller, Prop_Data, "m_iName", BossCounterName, sizeof(BossCounterName));
	
	int offset = FindDataMapInfo(caller, "m_OutValue");
	
	float value = GetEntDataFloat(caller, offset);
	int intValue = RoundToZero(value);
	
	PrintHintText(activator, "Счётчик: %s \nЗначение: <span class='fontSize-xl'>%i</span>", BossCounterName, intValue);

	PrintToConsole(activator, "Counter: %s. Value: %i", BossCounterName, intValue);
}
