#include "Header.h"

int main(int argc, char *argv[]) 
{
	if (argc < 2) {
		perror("no input file detected\n");
		return -2;
	}

    FILE* in_file = fopen(argv[1], "r");
    if (in_file == NULL) {
        perror("Can't open file\n");
        exit(-1);
    }

    int V = 0, N = 0, vs, vt;
    fscanf(in_file, "%d %d", &V, &N);

    struct adjacency_list* graph = init_graph(V);
    int* weights = (int*)malloc(N * sizeof(int));
    if (weights == NULL) 
    {
        perror("Memory allocation failed\n");
        fclose(in_file);
        free_graph(graph);
        return -1;
    }

    while (fscanf(in_file, "%d %d", &vs, &vt) == 2) {
        for (int i = 0; i < N; i++) {
            fscanf(in_file, "%d", &weights[i]);
        }
        add_edge(graph, vs, vt, weights, N);
    }

    fclose(in_file);
    free(weights);

    int num_phases = N;  //  # phases = # dynamic weights
    int total_vertices = V * num_phases;

    //arr for distances and previus

    int* dist = (int*)malloc(total_vertices * sizeof(int));
    int* prev = (int*)malloc(total_vertices * sizeof(int));

    if (dist == NULL || prev == NULL) 
    {
        perror("Memory allocation failed!!\n");
        free(dist);
        free(prev);
        free_graph(graph);
        return -1;
    }

    int src, dest;
    while ((scanf("%d %d", &src, &dest) == 2)) {
        dijkstra(graph, src, num_phases, dist, prev);

        int best_phase = 0;
        int min_dist = INT_MAX; 
        for (int i = 0; i < num_phases; i++) {
            if (dist[dest * num_phases + i] < min_dist) {
                min_dist = dist[dest * num_phases + i];
                best_phase = dest * num_phases + i;
            }
        }
 
            print_path(prev, src * num_phases, best_phase, num_phases);
        
    }

    //clean
    free(dist);
    free(prev);
    free_graph(graph);
    return 0;
}
