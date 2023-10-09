
#include <stdio.h>
#include <stdint.h>	
/*
ЗАДАНИЕ:
В одномерном массиве поменять местами максимальный и минимальный элементы. 
*/
// Инициализируем первичный массив с числами
int32_t array_original [] = {45, 63, 12, 54, 9, 36, 19, 32}; //2D, 3F, 0C, 36, 09, 24, 13, 20

// Инициализируем указатель на новый массив. Начальное значение NULL
int32_t* array_result = NULL;
	
// Объявляем прототип функции, которая будет выполнять задание
int32_t* array_processing (int32_t* array_pointer, size_t array_size);	
	
// Объявляем прототип функции, которая будет вычислять сумму элементов массива
int32_t array_min (int32_t* array_pointer, size_t array_size);	
int32_t array_max (int32_t* array_pointer, size_t array_size);
	
//Экспортируем функцию	из main.s написанную на ассемблере.
extern void array_processing_asm (int32_t* array_pointer, size_t array_size, int32_t* new_array_pointer);	
extern int32_t array_minmax_asm (int32_t* array_pointer, size_t array_size);
extern int32_t array_change_asm (int32_t* array_pointer, size_t array_size);
extern int32_t array_copy_asm (int32_t* array_pointer, size_t array_size);
	
// Объявляем пустой массив для передачи его адреса в функцию array_processing_asm
int32_t new_array [sizeof(array_original)/sizeof(int32_t)]= {0};
	
int main (void)
{
	
	array_result = array_processing(array_original, sizeof(array_original)/sizeof(int32_t));
		
	array_processing_asm(array_original, sizeof(array_original)/sizeof(int32_t), new_array);
	
	while (1)
	{
	}
	return 0;
}

int32_t* array_processing (int32_t* array_pointer, size_t array_size)
{
	int32_t *new_array = NULL;
	int32_t min_index = 0;
    int32_t max_index = 0;
    
	new_array =  (int32_t*) (malloc(array_size));
	
	min_index = array_min(array_pointer, array_size);
    max_index = array_max(array_pointer, array_size);
	
	for (uint32_t i = 0; i < array_size; i++)
	{
        
		*(new_array + i) = *(array_pointer + i);
        
	}
    *(new_array + max_index) = *(array_pointer + min_index);
    *(new_array + min_index) = *(array_pointer + max_index);
	return new_array;
}


int32_t array_min (int32_t* array_pointer, size_t array_size)
{
    int32_t min_index = 0;
    int32_t min = *array_pointer;
	int32_t i = 0;
	
	while (i < array_size)
	{
        
        if (*(array_pointer + i) < min) {
            min = *(array_pointer+i);
            min_index = i;   
        }
        i++;
	}
	return min_index;
}

int32_t array_max (int32_t* array_pointer, size_t array_size)
{
    int32_t max_index = 0;
    int32_t max = *array_pointer;
	int32_t i = 0;
	
	while (i < array_size)
	{
        if (*(array_pointer + i) > max) {
            max = *(array_pointer+i);
            max_index = i;  
        }
        i++;
	}
	return max_index;
}
/********************************************************************************/