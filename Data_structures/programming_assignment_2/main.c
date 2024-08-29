#include "collision_detection.h"

int main(int argc, char *argv[])
{
         if(argc < 2){
                perror("no input.\n");
                return -2;
        }

        FILE* in_file = fopen(argv[1], "r");

        if (in_file == NULL) { //file dne
                perror("cant open.\n");
                exit(-1);
        }

        int capacity = 1;
        int count = 0;
        struct xy_coordinate* points = malloc(capacity * sizeof(struct xy_coordinate));

        if(points == NULL){
        perror("mem allocation failed\n");
        return -2;
        }

        // we want to scan coordinates into an arr to build our tree
        while (fscanf(in_file, "%lf %lf",&points[count].x,&points[count].y) == 2)
        {
        count ++; // count up in the array
        if (count >= capacity) // need to resize
                capacity *= 2; //armotized increased or whatevre

        struct xy_coordinate* temp = realloc(points, capacity * sizeof(struct xy_coordinate));

        if(temp == NULL)
        {
        perror("issue @ realloc\n");
        free(points);
        return -3;
        }

        points = temp; //now set the points to be this

        } //end while

        fclose(in_file);
        struct node*root = KD_tree(points, count, 0); //build KD tree

        struct query c;
        while(scanf("%lf %lf %lf", &c.center.x, &c.center.y, &c.radius) == 3 )
                printf("%d\n", searchTree(root, c));
        free_tree(root);
        free(points);
        return 0;
}