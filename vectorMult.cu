#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#define SIZE 3

__global__ void multi(int *vect,int *mat,int *result)
{
    int tid=blockDim.x*blockIdx.x;
    int value=0;
    for(int i=0;i<SIZE;i++)
    {
        value=value+(mat[i+tid]*vect[i]);
    }
    result[blockIdx.x]=value;
}
int main()
{
    srand(time(NULL));
    int a[SIZE][SIZE],b[SIZE],c[SIZE];
    int *dev_a,*dev_b,*dev_c;
    
    for(int i=0;i<SIZE;i++)
    {
        for(int j=0;j<SIZE;j++)
        {
          a[i][j]=rand()%50;
        }
    }
    
    for(int i=0;i<SIZE;i++)
    {
        b[i]=rand()%50;
        
    }
    
     printf("input A:");
    for(int i=0;i<SIZE;i++)
    {
       for(int j=0;j<SIZE;j++)
        {
          printf("%d ",a[i][j]);
        }
    }
    
    
    printf(" Input B : ");
    for(int i=0;i<SIZE;i++)
    {
        printf("%d ",b[i]);
    }
    
    cudaMalloc(&dev_a,SIZE*SIZE*sizeof(int));
    cudaMalloc(&dev_b,SIZE*sizeof(int));
    cudaMalloc(&dev_c,SIZE*sizeof(int));
    
    cudaMemcpy(dev_a,a,SIZE*SIZE*sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b,b,SIZE*sizeof(int),cudaMemcpyHostToDevice);
    multi<<<SIZE,SIZE>>>(dev_b,dev_a,dev_c);
    cudaMemcpy(&c,dev_c,SIZE*sizeof(int),cudaMemcpyDeviceToHost);
    
    printf(" Output : ");
    for(int i=0;i<SIZE;i++)
    {
        printf("%d ",c[i]);
    }
    
}