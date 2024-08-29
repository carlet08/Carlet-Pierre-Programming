#ifndef LINKED_LIST_H
#define LINKKED_LIST_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>


int get_operation(char* arr)
{
	if (strcmp(arr, "open") == 0)
		return 1;
	else if (strcmp(arr, "close") == 0)
		return 2;
	else if (strcmp(arr, "switch") == 0)
		return 3;
	else
		return -1; // something went wrong 
}


struct node {
	int value;
	struct node* next;
};

struct linked_list {//header
	struct node* head;
	struct node* tail;
};

struct linked_list init_linked_list()
{
	struct linked_list list;
	list.head = NULL;
	list.tail = NULL;
	return list;
}


bool is_empty(struct linked_list header)
{
	return header.head == NULL; //is the head empty?
}


void insert_head(struct linked_list* header, int value)
{
	// make mem for a new node
	struct node* new_node = (struct node*)malloc(sizeof(struct node));
	new_node->value = value;
	new_node->next = header->head; //former head
	header->head = new_node; //update header 
}



void print_list(struct linked_list header)
{
	struct node* curr = header.head;
	while (curr != NULL)
	{
		printf("%d", curr->value);
		curr = curr->next;
	}
	printf("\n");
}



void remove_node(struct linked_list* header, int value)
{
	assert(!is_empty(*header));
	struct node* prev = NULL;
	struct node* curr = header->head;

	while (curr != NULL && curr->value != value)
	{
		prev = curr;
		curr = curr->next;
	}

	if (curr == NULL)
	{
		printf("*****THIS WINDOW IS NOT OPEN ELSEWHERE**** \n");
		return ;
	}

	if (prev == NULL) //node is the head
		header->head = curr->next;
	else
		prev->next = curr->next;
	if (curr == header->tail) //is tail
		header->tail = prev;

	free(curr);
	return;

}

int switch_node(struct linked_list* header, int value)
{
	assert(!is_empty(*header));
	struct node* prev = NULL;
	struct node* curr = header->head;

	while (curr != NULL && curr->value != value)
	{
		prev = curr; 
		curr = curr->next;
	}

	if (curr == NULL) {
		printf("CAN'T FIND SPECIFIED WINDOW NO.%d \n", value);
		return -1;
	}

	if (curr == header->head)
		return value;//val is at the head

	if(prev != NULL)
		prev->next = curr->next; //rechain

	if (curr == header->tail)
		header->tail = prev; //update the tail

	curr->next = header->head; //former head
	header->head = curr; //update header 
	return header->head->value;
}

#endif // !1
