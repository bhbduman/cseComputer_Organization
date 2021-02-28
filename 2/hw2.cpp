#include <iostream>
using namespace std;
#define MAX_SIZE 20

int CheckSumPossibility(int num, int arr[], int size){
    int returnVal1=0, returnVal2=0;
    if (num == 0){//If sum becomes 0 that means it find a subset so it can return 1
        cout<<",";//to split numbers like if there is more then one pairs which gives the target number to split the i use comma
        return 1;
    }
    //if number becomes smaller than 0 that means the number which is substracted bigger than number so it returns 0 
    //also if the index smaller than zero that means it tries to out of index bound
    if(size <= 0 || num <0){
        return 0;
    }
    //for each call it substracts given indis from number and return next element of array to substract itand sends size-1 for the next tries
    if(CheckSumPossibility( num-arr[size-1], arr, size-1)){
        returnVal1= 1;
        cout<<arr[size-1]<<" "; // printing numbers which are sum of given value
    }
    //to send next index of to input so it can checjs alsa remaining items as different from  indis of given above
    if(CheckSumPossibility(num, arr, size-1)){
        returnVal2= 1;
        
    }    
    return returnVal1 || returnVal2;

}

int main(){
    int arraySize = MAX_SIZE;
    int arr[MAX_SIZE];
    int num;
    int returnVal;
    int sumarray=0;
    
    cin >> arraySize;
    cin >> num;
    
    for (int i = 0; i < arraySize; i++){
        cin >> arr[i];
        sumarray+=arr[i];//when it adds it also sum all of the array elements
    }
    if(sumarray < num){
        returnVal=0;    //if sum of array smaller than number it assigns 0    
    }
    else if(sumarray == num){
        returnVal=1;//if sum of all elements gives the target value it returns 1
        cout<<"All elements is sum subset of given value "<<endl;
    }
    else{
        cout<<"(";// I have to put them here to print paranthesies
        returnVal = CheckSumPossibility(num, arr, arraySize);
    }
    if(returnVal == 1){
        cout<<")"<<endl;
        cout << "Possible!" <<endl;
    }
    else{
        cout<<"\b";//if its impossible it deletes the paranthesies which is printed above
        cout << "Not possible" << endl;
    }
    


    return 0;
    
    
}

