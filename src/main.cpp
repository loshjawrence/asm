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

	// 128 sse
	__m128 a1 = { 0.0, 1.0, 2.0, 3.0 };
	__m128 a2 = { 2.0, 4.0, 6.0, 8.0 };
	__m128 a3 = _mm_add_ps(a1, a2);
	float f[4];
	// _mm_storer_ps(f, a3); // store aligned! f needs 16 byte alignment
	_mm_storeu_ps(f, a3); // store unaligned (f need not be aligned)

	// 256 are avx
	// d is for double
	// p is for packed
	__m256d v1 = { 0.0, 1.0, 2.0, 3.0 };
	__m256d v2 = { 2.0, 4.0, 6.0, 8.0 };
	__m256d v3 = _mm256_add_pd(v1, v2);
	double d[4];
	// _mm256_storer_pd(d, v3); // store aligned! f needs 32 byte alignment
	_mm256_storeu_pd(d, v3); // store unaligned (f need not be aligned)

	getchar();
	return 0;
}
