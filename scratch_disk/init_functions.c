#include <stdio.h>

__attribute((constructor(103))) static void init1(){
    printf("%s\n", __FUNCTION__);
}

__attribute__((constructor(102))) static void init2(){
    printf("%s\n", __FUNCTION__);
}

__attribute__((constructor)) void init3(){
    printf("%s\n", __FUNCTION__);
}

int main(int argc, char* argv[]){
    printf("Hello werld\n");
}

