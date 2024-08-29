#ifndef COLLISION_DETECTION_H
#define COLLISION_DETECTION_H

#include <assert.h>
#include <stdlib.h>
#include <math.h>
#include <stdio.h>

struct xy_coordinate { //points
	double x, y;
};

struct query { // query
	struct xy_coordinate center;
	double radius;
};

struct node { //node for my KD tree
	struct xy_coordinate point;
	struct node* left;
	struct node* right;
	int axis; // not sure if I want to keep this here
};



/*
input: list of points, point list, and the integer depth
output: a 2-d tree rooted @ median point of pointList
*/
//need a sorting algorithm

// Compare x for qsort
int compare_x(const void* a, const void* b) {
	//type cast
	const struct xy_coordinate* p1 = (const struct xy_coordinate*)a;
	const struct xy_coordinate* p2 = (const struct xy_coordinate*)b;

	if (p1->x < p2->x) return -1;
	if (p1->x > p2->x) return 1;
	return 0;
}

int compare_y(const void* a, const void* b) {
	//type cast
	const struct xy_coordinate* p1 = (const struct xy_coordinate*)a;
	const struct xy_coordinate* p2 = (const struct xy_coordinate*)b;

	if (p1->y < p2->y) return -1;
	if (p1->y > p2->y) return 1;
	return 0;
}

int find_median(struct xy_coordinate* points, int size, int axis) {
	if (axis == 0) //which axis are we on
		qsort(points, size, sizeof(struct xy_coordinate), compare_x);
	else 
		qsort(points, size, sizeof(struct xy_coordinate), compare_y);
	return size / 2;
}

struct node* KD_tree(struct xy_coordinate *points,int size ,int depth)
{
	if ( size <= 0) return NULL;
	int axis = depth % 2;
	int median = find_median(points, size, axis);

	struct node* root = (struct node*)malloc(sizeof(struct node));
	if (root == NULL) {
		perror("could not allocate mem for root\n");
		return NULL;
	}

	/**************construct subtree**********************
	* let node.location := median; 
	*node.left := kdtree(points in list before median, depth ++)
	* node.right := kdtree(points after median, depth + 1)
	* 
	*/
	 
	root->point = points[median];
	root->axis = axis;
	root->left = KD_tree(points, median, depth + 1);
	root->right = KD_tree(points + median + 1, size - median - 1, depth + 1);

	return root; //return the root

}


int searchTree(struct node* root, struct query circle)
{
	if (root == NULL) return 0;
	int count = 0;

	double distance = sqrt(pow(root->point.x - circle.center.x,2) + pow(root->point.y - circle.center.y,2));

	if(distance <= circle.radius)
		count++; //inside circle boundary

	int axis = root->axis;
	// Check which subtrees to recurse 
	if (axis == 0) { // check along x 
		if (circle.center.x - circle.radius <= root->point.x) {
			count += searchTree(root->left, circle);
		}
		if (circle.center.x + circle.radius >= root->point.x) { 
			count += searchTree(root->right, circle);
		}
	}
	else { // check along y
		if (circle.center.y - circle.radius <= root->point.y) {
			count += searchTree(root->left, circle);
		}
		if (circle.center.y + circle.radius >= root->point.y) { 
			count += searchTree(root->right, circle);
		}
	}
	return count;
}

void free_tree(struct node* root)
{
	//empty
	if (root == NULL) return;

	free_tree(root->left);
	free_tree(root->right);
	free(root);
}
#endif // !COLLISION_DETECTION_H
