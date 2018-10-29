#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#define SIZE 8

__global__ void vectAdd(int *a,int *b,int *c)
{
    const int tid=threadIdx.x;
    c[tid]=a[tid]+b[tid];
    
}

int main()
{
    srand(time(NULL));
    int a[SIZE],b[SIZE],c[SIZE];
    int *dev_a,*dev_b,*dev_c;
    
    for(int i=0;i<SIZE;i++)
    {
        a[i]=rand()%50;
        b[i]=rand()%50;
        c[i]=0;
    }
    
    printf(" Input A : ");
    for(int i=0;i<SIZE;i++)
    {
        printf("%d ",a[i]);
    }
    
    printf(" Input B : ");
    for(int i=0;i<SIZE;i++)
    {
        printf("%d ",b[i]);
    }
    
    cudaMalloc(&dev_a,SIZE*sizeof(int));
    cudaMalloc(&dev_b,SIZE*sizeof(int));
    cudaMalloc(&dev_c,SIZE*sizeof(int));
    
    cudaMemcpy(dev_a,a,SIZE*sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b,b,SIZE*sizeof(int),cudaMemcpyHostToDevice);
    vectAdd<<<1,SIZE>>>(dev_a,dev_b,dev_c);
    cudaMemcpy(&c,dev_c,SIZE*sizeof(int),cudaMemcpyDeviceToHost);
    
    printf(" Output : ");
    for(int i=0;i<SIZE;i++)
    {
        printf("%d ",c[i]);
    }
    
}