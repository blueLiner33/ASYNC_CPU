#define DISCS 6

struct move_info {
	
	short disc;
	unsigned char from, to;
};

int index;
struct move_info moves[ (1 << DISCS) - 1]; /* 2**DISCS - 1 */

void anoi (short n, char from, char to, char through ) {
	if (n!=1)
		anoi (n-1, from, through, to);
	
	moves[index].disc = n;
	moves[index].from = from;
	moves[index].to   = to;

	index++;

	if (n!=1)
		anoi (n-1, through, to, from);
}



int main (void){	

	int i;
	index = 0;
	
	anoi ( DISCS , 1, 3, 2 );
}


