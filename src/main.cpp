#include <iostream>

// Following Creel's series on x64 asm called "Modern x64 Assembly"

// extern means this symbol is external to this file.
// "C" is the C calling convention, C must be capitalized.
extern "C" uint64_t gcdEuclidsAlgo(uint64_t x, uint64_t y);

int main()
{
	std::cout << "\nResult of callAsm(): " << gcdEuclidsAlgo(57*232, 57*82) << "\n";

	getchar();
	return 0;
}
