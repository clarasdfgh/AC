	.file	"daxpy.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Introduzca un num\n"
.LC2:
	.string	"\ny[0]: %d, y[%d]: %d\n"
.LC3:
	.string	"Tiempo: %11.9f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L14
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movslq	%eax, %r12
	movq	%rax, %r15
	leaq	15(,%r12,4), %rax
	shrq	$4, %rax
	salq	$4, %rax
	subq	%rax, %rsp
	movq	%rsp, %r14
	subq	%rax, %rsp
	leaq	3(%rsp), %rbx
	movq	%rbx, %r13
	andq	$-4, %rbx
	shrq	$2, %r13
	testl	%r15d, %r15d
	js	.L3
	movl	%r15d, %edx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	leal	(%rax,%rax), %ecx
	movl	%eax, (%r14,%rax,4)
	movl	%ecx, (%rbx,%rax,4)
	movq	%rax, %rcx
	addq	$1, %rax
	cmpq	%rdx, %rcx
	jne	.L4
	xorl	%edi, %edi
	leaq	-96(%rbp), %rsi
	call	clock_gettime@PLT
	testl	%r15d, %r15d
	jle	.L7
	leal	-1(%r15), %edx
	movl	$1, %eax
	addq	$2, %rdx
	.p2align 4,,10
	.p2align 3
.L6:
	imull	$150, (%r14,%rax,4), %ecx
	addl	%ecx, (%rbx,%rax,4)
	addq	$1, %rax
	cmpq	%rax, %rdx
	jne	.L6
.L7:
	xorl	%edi, %edi
	leaq	-80(%rbp), %rsi
	call	clock_gettime@PLT
	movq	-72(%rbp), %rax
	pxor	%xmm0, %xmm0
	movl	%r15d, %edx
	subq	-88(%rbp), %rax
	pxor	%xmm1, %xmm1
	movl	(%rbx,%r12,4), %ecx
	leaq	.LC2(%rip), %rdi
	cvtsi2sdq	%rax, %xmm0
	movq	-80(%rbp), %rax
	subq	-96(%rbp), %rax
	divsd	.LC1(%rip), %xmm0
	cvtsi2sdq	%rax, %xmm1
	movl	0(,%r13,4), %esi
	xorl	%eax, %eax
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -104(%rbp)
	call	printf@PLT
	movsd	-104(%rbp), %xmm0
	movl	$1, %eax
	leaq	.LC3(%rip), %rdi
	call	printf@PLT
	movq	-56(%rbp), %rax
	xorq	%fs:40, %rax
	jne	.L15
	leaq	-40(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L3:
	.cfi_restore_state
	leaq	-96(%rbp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	jmp	.L7
.L15:
	call	__stack_chk_fail@PLT
.L14:
	movq	stderr(%rip), %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	orl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (Arch Linux 9.3.0-1) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
