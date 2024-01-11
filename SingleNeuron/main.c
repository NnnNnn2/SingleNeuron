#include <stdio.h>

/*
 *	1	*	w0	_
 *	X1	*	w1	_\
 *	X2	*	w2	__\
 *	X3	*	w3	___\	____
 *	X4	*	w4	____\	\	  ___\     Relu(Sum) { (Sum < 0) ? 0 : Sum; }
 *	.		.	____/	/___     /
 *	.		.	___/
 *	.		.	__/
 *	Xn	*	wn	_/
 */

float* single_neuron(double* X, float* w, unsigned int n);

int main()
{
	unsigned int n;
	double* X;
	float* w;
	scanf_s("%u", &n);
	X = malloc(n * sizeof(double));
	w = malloc((n + 1) * sizeof(float));
	for (int i = 0; i < n; i++)
		scanf_s("%lf", &X[i]);
	for (int i = 0; i <= n; i++)
		scanf_s("%f", &w[i]);
	float* result = single_neuron(X, w, n);
	printf("\n%f", *result);
	return 0;
}