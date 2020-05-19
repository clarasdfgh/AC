	.file	"daxpy.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Introduzca un num\n"
.LC4:
	.string	"\ny[0]: %d, y[%d]: %d\n"
.LC5:
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
	jle	.L22
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
	leal	1(%r15), %ecx
	cmpl	$2, %r15d
	jbe	.L15
	movl	%ecx, %edx
	movdqa	.LC0(%rip), %xmm1
	movdqa	.LC2(%rip), %xmm2
	xorl	%eax, %eax
	shrl	$2, %edx
	salq	$4, %rdx
	.p2align 4,,10
	.p2align 3
.L5:
	movdqa	%xmm1, %xmm0
	paddd	%xmm2, %xmm1
	movups	%xmm0, (%r14,%rax)
	pslld	$1, %xmm0
	movups	%xmm0, (%rbx,%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L5
	movl	%ecx, %eax
	andl	$-4, %eax
	andl	$3, %ecx
	je	.L6
.L4:
	movslq	%eax, %rdx
	leal	(%rax,%rax), %ecx
	movl	%eax, (%r14,%rdx,4)
	movl	%ecx, (%rbx,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %r15d
	jl	.L6
	movslq	%edx, %rcx
	addl	$2, %eax
	movl	%edx, (%r14,%rcx,4)
	addl	%edx, %edx
	movl	%edx, (%rbx,%rcx,4)
	cmpl	%eax, %r15d
	jl	.L7
	movslq	%eax, %rdx
	movl	%eax, (%r14,%rdx,4)
	addl	%eax, %eax
	movl	%eax, (%rbx,%rdx,4)
.L7:
	leaq	-96(%rbp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
.L8:
	leal	-1(%r15), %eax
	cmpl	$2, %eax
	jbe	.L16
	movl	%r15d, %edx
	movl	$4, %eax
	shrl	$2, %edx
	salq	$4, %rdx
	addq	$4, %rdx
	.p2align 4,,10
	.p2align 3
.L11:
	movdqu	(%r14,%rax), %xmm1
	movdqu	(%r14,%rax), %xmm3
	movdqu	(%rbx,%rax), %xmm4
	pslld	$2, %xmm1
	paddd	%xmm3, %xmm1
	movdqa	%xmm1, %xmm0
	pslld	$4, %xmm0
	psubd	%xmm1, %xmm0
	pslld	$1, %xmm0
	paddd	%xmm4, %xmm0
	movups	%xmm0, (%rbx,%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L11
	movl	%r15d, %edx
	andl	$-4, %edx
	leal	1(%rdx), %eax
	cmpl	%edx, %r15d
	je	.L9
.L10:
	movslq	%eax, %rdx
	imull	$150, (%r14,%rdx,4), %ecx
	addl	%ecx, (%rbx,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%r15d, %edx
	jg	.L9
	movslq	%edx, %rdx
	addl	$2, %eax
	imull	$150, (%r14,%rdx,4), %ecx
	addl	%ecx, (%rbx,%rdx,4)
	cmpl	%r15d, %eax
	jg	.L9
	cltq
	imull	$150, (%r14,%rax,4), %edx
	addl	%edx, (%rbx,%rax,4)
.L9:
	xorl	%edi, %edi
	leaq	-80(%rbp), %rsi
	call	clock_gettime@PLT
	movq	-72(%rbp), %rax
	pxor	%xmm0, %xmm0
	movl	%r15d, %edx
	subq	-88(%rbp), %rax
	pxor	%xmm1, %xmm1
	movl	(%rbx,%r12,4), %ecx
	leaq	.LC4(%rip), %rdi
	cvtsi2sdq	%rax, %xmm0
	movq	-80(%rbp), %rax
	subq	-96(%rbp), %rax
	divsd	.LC3(%rip), %xmm0
	cvtsi2sdq	%rax, %xmm1
	movl	0(,%r13,4), %esi
	xorl	%eax, %eax
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -104(%rbp)
	call	printf@PLT
	movsd	-104(%rbp), %xmm0
	movl	$1, %eax
	leaq	.LC5(%rip), %rdi
	call	printf@PLT
	movq	-56(%rbp), %rax
	xorq	%fs:40, %rax
	jne	.L23
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
.L6:
	.cfi_restore_state
	xorl	%edi, %edi
	leaq	-96(%rbp), %rsi
	call	clock_gettime@PLT
	testl	%r15d, %r15d
	jg	.L8
	jmp	.L9
.L3:
	leaq	-96(%rbp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	jmp	.L9
.L16:
	movl	$1, %eax
	jmp	.L10
.L15:
	xorl	%eax, %eax
	jmp	.L4
.L23:
	call	__stack_chk_fail@PLT
.L22:
	movq	stderr(%rip), %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	.LC1(%rip), %rdi
	call	fwrite@PLT
	orl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC2:
	.long	4
	.long	4
	.long	4
	.long	4
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (Arch Linux 9.3.0-1) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
