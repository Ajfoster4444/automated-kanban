#ifndef AST_H
#define AST_H


#include "symboltable.h"


/* NODE TYPES */

typedef enum Node_Type {
	NODE, // for roots only
	DATUM_NODE,
	CONST_NODE,
	OPERATOR_NODE,
	INPUT_NODE,
	OUTPUT_NODE,
	SUBGRAPH_NODE,
	EXPAND_NODE,
} Node_Type;

/* Basic Node */
typedef struct AST_Node {
	enum Node_Type type;
	struct AST_Node *left;
	struct AST_Node *right;
}AST_Node;

typedef struct AST_NODE_DATUM {
	enum Node_Type type;

	int data_type;

	list_t **names;
	int names_count;
}AST_NODE_DATUM;

#endif
