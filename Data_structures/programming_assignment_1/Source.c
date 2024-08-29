#include "Header.h"


int main()
{
	char input_string[100];
	char operation[10];
	int input_number, operation_number;
	struct linked_list my_list = init_linked_list(); //initialize our list

	//printf("enter a string: ");

	do
	{
		int i = 0;
		fgets(input_string, sizeof(input_string), stdin);
		memset(operation, 0, sizeof(operation)); //clear our command array


		while (input_string[i] != '\0' && input_string[i] != ' ')
		{
			operation[i] = input_string[i]; // cpy the operation
			i++;
		}
			

		operation[i] = '\0'; // insert null terminator 
		operation_number = get_operation(operation); //now we know the operation to do
		while (input_string[i] == ' ') i++; //move past any spaces
		input_number = atoi(&input_string[i]);

//****************************************************************************************

		switch (operation_number)
		{
		case 1: //open
			insert_head(&my_list, input_number);
			printf("%d\n", my_list.head->value);
			break;
		case 2: //close
			remove_node(&my_list, input_number);
			if(!is_empty(my_list)) //dont print the last closed 
				printf("%d\n", my_list.head->value);
			break;
		case 3: //switch
			printf("%d\n", switch_node(&my_list, input_number));
			break;
		default:
			printf("Not a recognized operation got opNo: %d \n", operation_number);
			break;

		}
	} while (!is_empty(my_list));



	return 0;
}

