#include <iostream>
#include <intrin.h>

// Following Creel's series on x64 asm called "Modern x64 Assembly"

// extern means this symbol is external to this file.
// "C" is the C calling convention, C must be capitalized.
// extern "C" int* whileLoop();
extern "C" int* testSIMD();

int main()
{
	std::cout << "\nResult of callAsm(): " << testSIMD() << "\n";

	// // someArray
	// int* someArray = whileLoop();
	// std::cout << "\nResult of callAsm(): " << someArray << "\n";
	// for (auto i = 0; i < 4; i++)
	// {
	// 	std::cout << " " << *(someArray++);
	// }

	// 256 are avx
	// d is for double
	// p is for packed
	__m256d a = { 0.0, 1.0, 2.0, 3.0 };
	__m256d b = { 2.0, 4.0, 6.0, 8.0 };
	__m256d c = _mm256_add_pd(a, b);
	getchar();
	return 0;
}
