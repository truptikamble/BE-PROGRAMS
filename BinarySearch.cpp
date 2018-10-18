#include<iostream>
#include<omp.h>
using namespace std;

int binarySearch(int arr[], int low, int high, int key) 
{ 
int flag=-1;
#pragma omp parallel sections
{

#pragma omp section
{
    while (low <= high) 
    { 
        int mid = low + (high-low)/2;   
        if (arr[mid] == key) 
        {
        	flag=mid;  
        }	
        
        if (arr[mid] < key) 
        low = mid + 1; 
        else
        high = mid - 1; 
    }
}
}       
    // if we reach here, then element was 
    // not present 
    return flag; 

} 
  
int main() 
{ 
  int n,key;

  cout<<"\n Enter total no of elements=>";
  cin>>n; 
  int a[n];

  cout<<"\n Enter elements :\n";
  for(int i=0;i<n;i++)
  {
     cin>>a[i];
  }
  cout<<"\n Enter key to find :\n";
  cin>>key;
     
  int result = binarySearch(a, 0, n-1, key); 

  (result == -1)? printf("Element is not present in array") : printf("Element is present at index %d", result+1); 

   return 0; 

} 