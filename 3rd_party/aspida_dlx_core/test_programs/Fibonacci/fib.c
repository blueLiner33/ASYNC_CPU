#define N 10

int fib(int n){
//	return	(n<2) ? n : fib(n-1) + fib(n-2);
	switch (n) {
		case 0:
			return -8;
		case 1:
			return 5;
		default:
			return fib(n-1) + fib(n-2);
	}
}

short int results_char[N];
int results_int[N];

int main(){
	
	int i;
	
	for(i=0;i<N;i++){
		results_char[i] = fib(i);
		results_int[i] = results_char[i];
	}
}
