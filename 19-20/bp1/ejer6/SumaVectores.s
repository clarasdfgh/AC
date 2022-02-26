	.file	"SumaVectores.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"Faltan n\302\272 componentes del vector"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Tama\303\261o Vectores:%u (%lu B)\n"
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"/ V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n"
	.align 8
.LC4:
	.string	"Tiempo:%11.9f\t / Tama\303\261o Vectores:%u\t/ V1[0]+V2[0]=V3[0](%8.6f+%8.6f=%8.6f) / / V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n"
	.align 8
.LC5:
	.string	"Tiempo:%11.9f\t / Tama\303\261o Vectores:%u\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L22
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$33554432, %ebp
	call	strtol@PLT
	movl	$4, %edx
	leaq	.LC1(%rip), %rdi
	movq	%rax, %rbx
	movl	%eax, %esi
	xorl	%eax, %eax
	call	printf@PLT
	cmpl	$33554432, %ebx
	cmovbe	%ebx, %ebp
	testl	%ebx, %ebx
	je	.L3
	pxor	%xmm1, %xmm1
	leaq	v1(%rip), %r12
	xorl	%eax, %eax
	movsd	.LC2(%rip), %xmm3
	cvtsi2sdl	%ebp, %xmm1
	leaq	v2(%rip), %r13
	mulsd	%xmm3, %xmm1
	.p2align 4,,10
	.p2align 3
.L4:
	pxor	%xmm0, %xmm0
	movapd	%xmm1, %xmm2
	movapd	%xmm1, %xmm7
	cvtsi2sdl	%eax, %xmm0
	mulsd	%xmm3, %xmm0
	addsd	%xmm0, %xmm2
	subsd	%xmm0, %xmm7
	movsd	%xmm2, (%r12,%rax,8)
	movsd	%xmm7, 0(%r13,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %ebp
	ja	.L4
	movq	%rsp, %rsi
	xorl	%edi, %edi
	leaq	v3(%rip), %r14
	call	clock_gettime@PLT
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L6:
	movsd	(%r12,%rax,8), %xmm0
	addsd	0(%r13,%rax,8), %xmm0
	movsd	%xmm0, (%r14,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %ebp
	ja	.L6
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	24(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	8(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC6(%rip), %xmm0
	addsd	%xmm1, %xmm0
	cmpl	$9, %ebx
	jbe	.L10
	leal	-1(%rbp), %eax
	movsd	(%r14), %xmm3
	movsd	0(%r13), %xmm2
	movl	%ebp, %esi
	movsd	(%r14,%rax,8), %xmm6
	movq	%rax, %rdx
	movl	%eax, %r8d
	movl	%eax, %ecx
	movsd	0(%r13,%rax,8), %xmm5
	movsd	(%r12,%rax,8), %xmm4
	leaq	.LC4(%rip), %rdi
	movl	$7, %eax
	movsd	(%r12), %xmm1
	call	printf@PLT
.L9:
	movq	40(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L23
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L10:
	.cfi_restore_state
	movl	%ebp, %esi
	leaq	.LC5(%rip), %rdi
	movl	$1, %eax
	xorl	%ebx, %ebx
	call	printf@PLT
	leaq	.LC3(%rip), %r15
	.p2align 4,,10
	.p2align 3
.L8:
	movsd	(%r12,%rbx,8), %xmm0
	movsd	(%r14,%rbx,8), %xmm2
	movl	%ebx, %ecx
	movl	%ebx, %edx
	movsd	0(%r13,%rbx,8), %xmm1
	movl	%ebx, %esi
	movq	%r15, %rdi
	movl	$3, %eax
	addq	$1, %rbx
	call	printf@PLT
	cmpl	%ebx, %ebp
	ja	.L8
	jmp	.L9
.L3:
	movq	%rsp, %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	24(%rsp), %rax
	pxor	%xmm0, %xmm0
	xorl	%esi, %esi
	subq	8(%rsp), %rax
	pxor	%xmm1, %xmm1
	leaq	.LC5(%rip), %rdi
	cvtsi2sdq	%rax, %xmm0
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	divsd	.LC6(%rip), %xmm0
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	printf@PLT
	jmp	.L9
.L23:
	call	__stack_chk_fail@PLT
.L22:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.comm	v3,268435456,32
	.comm	v2,268435456,32
	.comm	v1,268435456,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	2576980378
	.long	1069128089
	.align 8
.LC6:
	.long	0
	.long	1104006501
	.ident	"GCC: (Arch Linux 9.2.1+20200130-2) 9.2.1 20200130"
	.section	.note.GNU-stack,"",@progbits
