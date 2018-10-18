#include<stdio.h>
#include<omp.h>

void merging(int a[],int low, int mid, int high)
 { 
   int b[10];
   int l1,l2, i;

   for(l1 = low, l2 = mid + 1, i = low; l1 <= mid && l2 <= high; i++)
   {
      if(a[l1] <= a[l2])
         b[i] = a[l1++];
      else
         b[i] = a[l2++];
   }
   
   while(l1 <= mid)    
      b[i++] = a[l1++];

   while(l2 <= high)   
      b[i++] = a[l2++];

   for(i = low; i <= high; i++)
      a[i] = b[i];
}

void sort(int a[],int low, int high)
{
   int mid;
   
   if(low < high) 
   {
      mid = (low + high) / 2;
      #pragma omp parallel sections num_threads(2)
      {
        #pragma omp section
          {
               sort(a,low, mid);
          }

        #pragma omp section
          {
       sort(a,mid+1, high);
          }
      }      
      merging(a,low, mid, high);
   } 
   else 
   { 
      return;
   }   
}

int main() 
{ 
   int i,size;
   printf("Enter total no. of elements:\n");
   scanf("%d",&size);

   int array[size];

   printf("Enter %d elements:\n",size);
   for(i=0; i<size; i++)
   {
  scanf("%d",&array[i]);
   }



   printf("List before sorting\n");
   
   for(i = 0; i <= size-1; i++)
      printf("%d ", array[i]);

   sort(array,0,size-1);

   printf("\nList after sorting\n");
   
   for(i = 0; i <= size-1; i++)
      printf("%d ", array[i]);
}