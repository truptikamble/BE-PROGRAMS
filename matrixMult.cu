#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#define SIZE 3

__global__ void multi(int *Md, int *Nd, int *Pd) {
    //2D Thread ID
    int tx = threadIdx.x;
    int ty = threadIdx.y;

    //Pvalue stores the Pd element that is computed by the thread
    int Pvalue = 0;

    for(int k = 0; k <SIZE ; ++k)
    {
        int Mdelement = Md[ty*SIZE + k];
        int Ndelement = Nd[k*SIZE + tx];
        Pvalue += (Mdelement*Ndelement);
    }

    Pd[ty*SIZE + tx] = Pvalue;
}
int main()
{
    srand(time(NULL));
    int a[SIZE*SIZE],b[SIZE*SIZE],c[SIZE*SIZE];
    int *dev_a,*dev_b,*dev_c;
    
    for(int i=0;i<SIZE*SIZE;i++)
    {
        a[i]=rand()%50;
        b[i]=rand()%50;
     
    }
    
    
     printf("input A:");
    for(int i=0;i<SIZE*SIZE;i++)
    {
       
          printf("%d ",a[i]);
        
    }
    
    printf("input B:");
    for(int i=0;i<SIZE*SIZE;i++)
    {
       
          printf("%d ",b[i]);
        
    }
    
    dim3 dimGrid(1,1);
    dim3 dimBlock(3,3);
    
    cudaMalloc(&dev_a,SIZE*SIZE*sizeof(int));
    cudaMalloc(&dev_b,SIZE*SIZE*sizeof(int));
    cudaMalloc(&dev_c,SIZE*SIZE*sizeof(int));
    
    cudaMemcpy(dev_a,a,SIZE*SIZE*sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b,b,SIZE*SIZE*sizeof(int),cudaMemcpyHostToDevice);
    multi<<<dimGrid,dimBlock>>>(dev_a,dev_b,dev_c);
    cudaMemcpy(&c,dev_c,SIZE*SIZE*sizeof(int),cudaMemcpyDeviceToHost);
    
    printf("Output :");
    for(int i=0;i<SIZE*SIZE;i++)
    {
       
          printf("%d ",c[i]);
        
    }
    
}