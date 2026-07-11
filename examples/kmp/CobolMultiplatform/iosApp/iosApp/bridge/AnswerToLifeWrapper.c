//==========================================================================
// Implement a wrapper around our COBOL procedure with a nicer
// interface than what the transpiled COBOL provides directly.
//==========================================================================

// Declare the COBOL program.
extern int ANSWER__TO__LIFE(const char *, int *);

// Create C wrapper around the COBOL program.
int answerToLife(const char *filePath) {
	int result = 0;
	ANSWER__TO__LIFE(filePath, &result);
	return result;
}
