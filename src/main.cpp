#include <iostream>

// Following Creel's series on x64 asm called "Modern x64 Assembly"

// extern means this symbol is external to this file.
// "C" is the C calling convention, C must be capitalized.
extern "C" int callAsm();

int main()
{
	std::cout << "\nResult of callAsm(): " << callAsm() << "\n";

	getchar();
	return 0;
}
