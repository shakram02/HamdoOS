#include <stdio.h>

void init1() {

printf("%s\n", __FUNCTION__);

}

void init2() {

printf("%s\n", __FUNCTION__);

}

// Without typedef, init is a definition of a function
// pointer, with typedef init is a declaration of a 
// type
typedef void (*init)();

__attribute__((section(".init_array"))) init init_arr[2] = {
        init1, init2
};

int main(int argc, char* argv[]){
    printf("Hello morld\n");
}

