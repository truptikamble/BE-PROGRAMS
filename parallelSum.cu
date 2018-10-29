#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#define SIZE 8

__global__ void max(int *input)
{
    const int tid=threadIdx.x;
    int stepsize=1;
    int numThreads=blockDim.x;
    
    while(numThreads>0)
    {
        if(tid<numThreads)
        {
            int first=tid*stepsize*2;
            int second=first+stepsize;
            input[first]+=input[second];
        }
        
        stepsize <<=1;
        numThreads >>=1;
    }
    
}

int main()
{
    srand(time(NULL));
    int a[SIZE],result;
    int *dev_a;
    
    for(int i=0;i<SIZE;i++)
    {
        a[i]=rand()%50;
    }
    
    printf(" Input : ");
    for(int i=0;i<SIZE;i++)
    {
        printf("%d ",a[i]);
    }
    
    cudaMalloc(&dev_a,SIZE*sizeof(int));
    
    cudaMemcpy(dev_a,a,SIZE*sizeof(int),cudaMemcpyHostToDevice);
    max<<<1,SIZE/2>>>(dev_a);
    cudaMemcpy(&result,dev_a,sizeof(int),cudaMemcpyDeviceToHost);
    
    printf(" Output %d",result);
    
}