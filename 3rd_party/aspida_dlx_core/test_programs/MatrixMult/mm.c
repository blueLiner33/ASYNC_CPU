//#include <stdio.h>

#define N 10

int mult(int a, int b) {
	
	char negative = 0;
	int result = 0;
	int i;

	if (a < 0) {
		negative = 1;
		a = -a;
	}

	if (b < 0) {
		negative ^= 1;
		b = -b;
	} else if (b == 0)
		return 0;

	for (i=0; a>0; i++) {
		if (a & 1) {
			result += b << i;
		}
		a >>= 1;
	}

	if (negative)
		result = -result;
	
	return result;
}

void mm (int A[N][N], int B[N][N], int C[N][N], int n){

	int i, j, k;
	
	for (i=0; i<n; i++) {
		for (j=0; j<n; j++) {
			C[i][j] = 0;
			for (k=0; k<n; k++)
				C[i][j] += A[i][k] * B[k][j];
		}
	}
}
	
int A[N][N], B[N][N], C[N][N];
	

int main(int argc, char *argv[]){

	int i, j;

	for (i=0; i<N; i++) {
		for (j=0; j<N; j++) {
			A[i][j] = i+j;
			B[i][j] = i-j;
		}
	}
	

	mm (A, B, C, N);
	
/*	printf("***************** C *************\n");
	for (i=0; i<N; i++) {
		for (j=0; j<N; j++)
			printf("%6d ", C[i][j]);
		printf("\n");
	}*/

	return 0;
}
