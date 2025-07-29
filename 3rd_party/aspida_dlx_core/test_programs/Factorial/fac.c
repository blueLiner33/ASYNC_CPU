#define N 6

int fac(int n){
	return	(n<2) ? 1:
		n*fac(n-1);
}

int		results_int[N];
short	results_short[N];
char	results_char[N];

int final[N*3];

int main(){
	int i;
	for(i=0;i<N;i++){
		results_int[i] = 
		results_short[i] = 
		results_char[i] = fac(i);
	}
	
	for(i=0;i<N;i++){
		final[i] = results_int[i];
		final[i+N] = results_short[i];
		final[i+N+N] = results_char[i];
	}
}
