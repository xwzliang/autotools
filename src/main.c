#include <libjupiter.h>

#define DEFAULT_SALUTATION "Hello"

int main(int argc, char * argv[]) {
	const char * salutation = DEFAULT_SALUTATION;
	jupiter_print(salutation, argv[0]);
	return 0;
}
