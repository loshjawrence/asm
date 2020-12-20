#include <iostream>

// Following Creel's series on x64 asm called "Modern x64 Assembly"

// extern means this symbol is external to this file.
// "C" is the C calling convention, C must be capitalized.
// extern "C" int* whileLoop();
extern "C" int* gcdEuclidsAlgo();

int main()
{
	std::cout << "\nResult of callAsm(): " << gcdEuclidsAlgo() << "\n";

	// // someArray
	// int* someArray = whileLoop();
	// std::cout << "\nResult of callAsm(): " << someArray << "\n";
	// for (auto i = 0; i < 4; i++)
	// {
	// 	std::cout << " " << *(someArray++);
	// }

	getchar();
	return 0;
}
