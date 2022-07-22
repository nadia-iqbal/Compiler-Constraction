#include<stdio.h>

typedef struct
{
    double weight, price, unitPrice;
} object;

double fractionalKnapsack(object obj[], int n, int capacity)
{
    double profit = 0.0;
    int i, j;
    for(i=0; i<n-1; i++)
    {
        for(j=0; j<n-1-i; j++)
        {
            if(obj[j].unitPrice < obj[j+1].unitPrice)
            {
                object temp = obj[j];
                obj[j] = obj[j+1];
                obj[j+1] = temp;
            }
        }
    }

    for(i=0; i<n; i++)
    {
        if(obj[i].weight <= capacity)
        {
            profit += obj[i].price;
            capacity -= obj[i].weight;
        }
        else
        {
            profit += capacity*obj[i].unitPrice;
            capacity = 0;
            break;
        }
    }

    return profit;
}

int main()
{
    int n, i, capacity;
    printf("Enter the number of items: ");
    scanf("%d", &n);
    object obj[n];
    for(i=0; i<n; i++)
    {
        scanf("%lf %lf", &obj[i].weight, &obj[i].price);
        obj[i].unitPrice = obj[i].price/obj[i].weight;
    }


    printf("Enter the capacity: ");
    scanf("%d", &capacity);

    double result = fractionalKnapsack(obj, n, capacity);
    printf("Maximum profit: %.3lf\n", result);

    for(i=0; i<n; i++)
    {
        printf("%.2lf %.2lf %.2lf\n", obj[i].weight, obj[i].price, obj[i].unitPrice);
    }
    int a = (int)(pow(5, 2) + 1e-9);
    int b = round(pow(5,2));
    printf("%d \n%d", a, b);

    return 0;
}
