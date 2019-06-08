//==============================================================================\\
// Скрипт, разблокирующий второй и третий уровни и материи на карте (by Walderr)
//==============================================================================\\

winsCounter <- 0;	// Количество побед.

function nextLevel() // Вызывается в конце раунда
{
	winsCounter++;
	EntFire("console", "Command", "say Уровень пройден!", 0.0);
}

function setCounter() // Вызывается в начале раунда
{
	if(winsCounter == 0) EntFire("console", "Command", "say Normal LVL!", 0.0);
	
	else if(winsCounter == 1)
	{
		DoEntFire("math_counter", "Add", "1", 0, self, self);
		EntFire("console", "Command", "say Hard LVL!", 0.0);
	}
	else if(winsCounter >= 2)
	{
		DoEntFire("math_counter", "Add", "2", 0, self, self);
		EntFire("console", "Command", "say Extra Hard LVL!", 0.0);
	}
}

function Jump() // Вызывается когда зомби использовал ZombieJumper
{
	//ScriptPrintMessageChatAll("ZombieJumper использован!");
	
	// Зомби должен подпрыгивать.
}

function PenisJump() // Вызывается когда человек использовал PenisGun
{
	//ScriptPrintMessageChatAll("PenisGun использован!");
	
	// Человек должен подлетать и ускоряться.
}

function setMinesSpawnAmount(minesCount) // Устанавливает количество мин
{
	//ScriptPrintMessageChatAll("Количество мин установлено на " +minesCount+ "!");
	
	// Установка количества мин для появления на уровне.
}

function SpawnMine() // Вызывается для спавна мин
{
	//ScriptPrintMessageChatAll("Мина появилась!");
	
	// Мины должны появляться.
}
