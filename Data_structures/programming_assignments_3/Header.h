#ifndef DIJSTRAKS_H
#define DIJSTRAKS_H
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>



//*****building the graph***********
struct vertex {
    int target;
    int* weights;
    int num_weights;
    struct vertex* next;
};

struct adjacency_list {
    struct vertex** neighbors;
    int num_vertices;
};

struct vertex* add_vertex(int target, int* weights, int N) {
    struct vertex* adj = (struct vertex*)malloc(sizeof(struct vertex));
    if (adj == NULL) 
    {
        perror("can't alloc mem. @vertex");
        return NULL;
    }
    adj->target = target;
    adj->num_weights = N;
    adj->weights = (int*)malloc(N * sizeof(int));
    if (adj->weights == NULL) {
        perror("can't alloc mem. @ weights");
        free(adj);
        return NULL;
    }
    //copy the amount weights based on N
    for (int i = 0; i < N; i++) {
        adj->weights[i] = weights[i];
    }
    adj->next = NULL;
    return adj;
}

//  initialize the graph
struct adjacency_list* init_graph(int num_vertices) {
    struct adjacency_list* graph = (struct adjacency_list*)malloc(sizeof(struct adjacency_list));
    if (graph == NULL) {
        perror("can't alloc mem. @ graph");
        return NULL;
    }
    graph->num_vertices = num_vertices;
    graph->neighbors = (struct vertex**)malloc(num_vertices * sizeof(struct vertex*));
    if (graph->neighbors == NULL) {
        perror("can't alloc mem. @ adjacency list");
        free(graph);
        return NULL;
    }
    for (int i = 0; i < num_vertices; i++) { //set all neighbors to NULL first
        graph->neighbors[i] = NULL;
    }
    return graph;
}

void add_edge(struct adjacency_list* graph, int src, int dst, int* weights, int N) {
    struct vertex* adj = add_vertex(dst, weights, N);
    adj->next = graph->neighbors[src];
    graph->neighbors[src] = adj;
}

void free_graph(struct adjacency_list* graph) {
    for (int i = 0; i < graph->num_vertices; i++) {
        struct vertex* adj = graph->neighbors[i];
        while (adj != NULL) {
            struct vertex* temp = adj;
            adj = adj->next;
            free(temp->weights);
            free(temp);
        }
    }
    free(graph->neighbors);
    free(graph);
}

//************short path algo*****************
// 
#define PQ_SIZE 100 
#define HASH_SIZE 1000 

struct hash_node {
    int v;
    struct hash_node* next;
};

struct hash_table {
    struct hash_node** nodes;
};

struct hash_table* make_table() {
    struct hash_table* table = (struct hash_table*)malloc(sizeof(struct hash_table));
    table->nodes = (struct hash_node**)malloc(HASH_SIZE * sizeof(struct hash_node*));
    for (int i = 0; i < HASH_SIZE; i++) {
        table->nodes[i] = NULL;
    }
    return table;
}

int hash_func(int vertex) {
    return vertex % HASH_SIZE;
}


void insert_hash(struct hash_table* table, int vertex) {
    int idx = hash_func(vertex);
    struct hash_node* new_node = (struct hash_node*)malloc(sizeof(struct hash_node));
    new_node->v = vertex;
    new_node->next = table->nodes[idx];
    table->nodes[idx] = new_node;
}

int in_hash(struct hash_table* table, int vertex) {
    int idx = hash_func(vertex);
    struct hash_node* node = table->nodes[idx];
    while (node != NULL) {
        if (node->v == vertex) {
            return 1; // yes
        }
        node = node->next;
    }
    return 0; //no
}

void free_hash(struct hash_table* table) {
    for (int i = 0; i < HASH_SIZE; i++) {
        struct hash_node* node = table->nodes[i];
        while (node != NULL) {
            struct hash_node* temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(table->nodes);
    free(table);
}

struct pq_node {
    int vertex;
    int dist;
};

struct pq {
    struct pq_node* nodes;
    int size;
    int capacity;
};

struct pq* add_pq(int capacity) {
    struct pq* queue = (struct pq*)malloc(sizeof(struct pq));
    queue->nodes = (struct pq_node*)malloc(capacity * sizeof(struct pq_node));
    queue->size = 0;
    queue->capacity = capacity;
    return queue;
}

void swap(struct pq_node* a, struct pq_node* b) {
    struct pq_node temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up(struct pq* queue, int idx) {
    while (idx > 0 && queue->nodes[idx].dist < queue->nodes[(idx - 1) / 2].dist) {
        swap(&queue->nodes[idx], &queue->nodes[(idx - 1) / 2]);
        idx = (idx - 1) / 2;
    }
}

void heapify_down(struct pq* queue, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < queue->size && queue->nodes[left].dist < queue->nodes[smallest].dist) 
        smallest = left;
    if (right < queue->size && queue->nodes[right].dist < queue->nodes[smallest].dist) 
        smallest = right;
    if (smallest != idx) {
        swap(&queue->nodes[idx], &queue->nodes[smallest]);
        heapify_down(queue, smallest);
    }
}

void pq_push(struct pq* queue, int vertex, int dist) {
    if (queue->size == queue->capacity) { //armotized growth here
        queue->capacity *= 2;
        queue->nodes = (struct pq_node*)realloc(queue->nodes, queue->capacity * sizeof(struct pq_node));
    }
    queue->nodes[queue->size].vertex = vertex;
    queue->nodes[queue->size].dist = dist;
    heapify_up(queue, queue->size);
    queue->size++;
}

struct pq_node pq_pop(struct pq* queue) {
    if (queue->size == 0) {
        struct pq_node empty_node = { -1, INT_MAX };
        return empty_node;
    }
    struct pq_node min_node = queue->nodes[0];
    queue->nodes[0] = queue->nodes[queue->size - 1];
    queue->size--;
    heapify_down(queue, 0);
    return min_node;
}

int pq_empty(struct pq* queue) {
    return queue->size == 0;
}

void free_pq(struct pq* queue) {
    free(queue->nodes);
    free(queue);
}



void print_path(int* prev, int start, int end, int num_phases) {
    if (start == end) {
        printf("%d\n", start / num_phases); 
        return;
    }

    if (prev[end] == -1) {
        printf("No path.\n");
        return;
    }

    int pl = 0;
    for (int v = end; v != -1; v = prev[v]) {
        pl++;
    }

    int* path = (int*)malloc(pl * sizeof(int));
    if (path == NULL) {
        perror("Can't allocate mem. @ path");
        return;
    }

    int count = 0;
    for (int v = end; v != -1; v = prev[v]) {
        path[count++] = v / num_phases; 
    }

    for (int i = count - 1; i >= 0; i--) {
        printf("%d ", path[i]);
    }
    printf("\n");

    free(path);
}



void dijkstra(struct adjacency_list* graph, int src, int num_phases, int* dist, int* prev) {
    struct pq* pq = add_pq(PQ_SIZE);
    int total_vertices = graph->num_vertices * num_phases;
    int* visited = (int*)calloc(total_vertices, sizeof(int));

    for (int i = 0; i < total_vertices; i++) { //all vert' have infinite dist 
        dist[i] = INT_MAX;
        prev[i] = -1;
    }

    dist[src * num_phases] = 0;
    pq_push(pq, src * num_phases, 0);

    while (!pq_empty(pq)) 
    {
        struct pq_node min_node = pq_pop(pq);
        int v = min_node.vertex;
        int phase = v % num_phases;

        struct vertex* adj = graph->neighbors[v / num_phases];
        while (adj != NULL) {
            int u_base = adj->target;
            int next_phase = (phase + 1) % num_phases;
            int u = u_base * num_phases + next_phase;

            int weight = adj->weights[phase];
            int total_weight = dist[v] + weight;

            if (total_weight < dist[u]) {
                dist[u] = total_weight;
                prev[u] = v; // predecessor
                pq_push(pq, u, total_weight);
            }
            adj = adj->next;
        }
    }

    free(visited);
    free_pq(pq);
}


#endif // !DIJSTRAKS_H
