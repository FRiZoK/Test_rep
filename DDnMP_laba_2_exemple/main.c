
#include <stdio.h>		/* Заголовочный файл объявляет несколько целочисленных типов и макросов */
#include <stdint.h>		/* Заголовочный файл объявляет несколько целочисленных типов и макросов */
/*
ЗАДАНИЕ:
Сформировать массив array[], в котором элементы равны сумме всех элементов массива array_original[] разделённые на номер элемента массива. 
*/
// Инициализируем первичный массив с числами
int32_t array_original [] = {68,-69,28,27,-62,58,-50,49,-75,96,-19,35,41,
	-79,52,86,55,82,71,90,-88,45,-94,-59,3,80,38,-87,57,-48,89,-15,-54,-40,
	97,16,98,-53,7,64,51,66,46,63,-24,37,-70,22,-78,67};

// Инициализируем указатель на новый массив. Начальное значение NULL
int32_t* array = NULL;
	
// Объявляем прототип функции, которая будет выполнять задание
int32_t* array_treatment (int32_t* array_ptr, size_t array_size);	
	
// Объявляем прототип функции, которая будет вычислять сумму элементов массива
int32_t array_sum (int32_t* array_ptr, size_t array_size);		
	
//Экспортируем функцию	из main.s написанную на ассемблере.
extern void array_treatment_asm (int32_t* array_ptr, size_t array_size, int32_t* new_array_ptr );	
extern int32_t array_sum_asm (int32_t* array_ptr, size_t array_size);
	
// Объявляем мпустой массив для передачи его адреса в функцию array_treatment_asm
int32_t new_array [sizeof(array_original)/sizeof(int32_t)]= {0};
	
int main (void)
{
	/*Вызываем функцию array_treatment. 
	Функция возвратит указатель на массив соответствующий заданию. 
	Размерность массива такая же как у оригинального массива.*/
	
	array = array_treatment(array_original, sizeof(array_original)/sizeof(int32_t));
	
	/*Вызываем функцию array_treatment_asm, тело которой описано в файле main_1.s. 
	Так как, в языке ассемблера не функций malloc() и вообще нет механизма выделения данных из кучи, 
	то мы заранее выделяем место в оперативной памяти для обработанного массива, 
	поэтому нам необходимо передать адрес нового массива в функцию. 
	Размерность массива такая же как у оригинального массива.*/
	
	array_treatment_asm(array_original, sizeof(array_original)/sizeof(int32_t), new_array);
	
	while (1)
	{
	}
	return 0;
}

/********************************************************************************/
/*Функция формирующая массив array[], в котором элементы равны сумме всех 
элементов массива array_original[] разделённые на номер элемента массива.*/
/********************************************************************************/
/*
Функция принимает:
	int32_t* array_ptr - указатель на исходный массив с элементами типа int32_t
	array_size				 - размер массива
Функция возвращает:
	указатель на область памяти в котором лежит новый массив
*/

int32_t* array_treatment (int32_t* array_ptr, size_t array_size)
{
	int32_t *new_array = NULL;
	int32_t sum = 0;
	
	//Выделяем область памяти для нового массива из кучи (heap).
	new_array =  (int32_t*) (malloc(array_size));
	
	// Вычисляем сумму элементов массива
	sum = array_sum(array_ptr, array_size);
	
	// При выполнении задачи происходит деление на ноль при заполнении первого элемента. Поэтому мы запишем в нулевой элемент массива максимальное число типа int32_t
	*(new_array+0) = ((uint32_t)(~0)) /2;
	
	for (uint32_t i = 1; i < array_size; i++)
	{
		*(new_array+i) = sum/i;
	}
	return new_array;
}

/********************************************************************************/
/*Функция рассчитывает сумму элементов массива*/
/********************************************************************************/
/*
Функция принимает:
	int32_t* array_ptr - указатель на исходный массив с элементами типа int32_t
	array_size				 - размер массива
Функция возвращает:
	сумму всех элементов массива
*/
int32_t array_sum (int32_t* array_ptr, size_t array_size)
{
	int32_t sum = 0;
	int32_t i = 0;
	
	while (i < array_size)
	{
		sum = sum + *(array_ptr+i);
		i++;
	}
	return sum;
}
/********************************************************************************/
