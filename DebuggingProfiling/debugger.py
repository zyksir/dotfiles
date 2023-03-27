# how to debug this program
# 1. run "python -m ipdb debuger.py" in terminal
# 2. using "c" to trig the bug
# 3. "p arr" to print array; "p locals()" to print all local variables
#   -> found we should change j loop to range(n-1)
# 4. ... try other commands and found bugs in swapping.
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(n):
            if arr[j] > arr[j + 1]:
                arr[j] = arr[j + 1]
                arr[j + 1] = arr[j]
    return arr


print(bubble_sort([4, 2, 1, 8, 7, 6]))
