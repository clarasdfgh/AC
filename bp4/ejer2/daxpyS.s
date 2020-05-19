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
	.globl	main
	.type	main, @function
main:
.LFB6:
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
	decl	%edi
	jg	.L2
	movq	stderr(%rip), %rsi
	leaq	.LC0(%rip), %rdi
	call	fputs@PLT
	orl	$-1, %edi
	call	exit@PLT
.L2:
	movq	8(%rsi), %rdi
	call	atoi@PLT
	movslq	%eax, %r12
	leaq	15(,%r12,4), %rax
	movq	%r12, %r14
	shrq	$4, %rax
	salq	$4, %rax
	subq	%rax, %rsp
	movq	%rsp, %r15
	subq	%rax, %rsp
	xorl	%eax, %eax
	leaq	3(%rsp), %rbx
	movq	%rbx, %r13
	andq	$-4, %rbx
	shrq	$2, %r13
.L3:
	cmpl	%eax, %r14d
	jl	.L10
	leal	(%rax,%rax), %edx
	movl	%eax, (%r15,%rax,4)
	movl	%edx, (%rbx,%rax,4)
	incq	%rax
	jmp	.L3
.L10:
	leaq	-88(%rbp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	xorl	%eax, %eax
.L5:
	incq	%rax
	cmpl	%eax, %r14d
	jl	.L11
	imull	$150, (%r15,%rax,4), %edx
	addl	%edx, (%rbx,%rax,4)
	jmp	.L5
.L11:
	xorl	%edi, %edi
	leaq	-72(%rbp), %rsi
	call	clock_gettime@PLT
	movq	-64(%rbp), %rax
	subq	-80(%rbp), %rax
	movl	%r14d, %edx
	cvtsi2sdq	%rax, %xmm0
	movq	-72(%rbp), %rax
	subq	-88(%rbp), %rax
	divsd	.LC1(%rip), %xmm0
	cvtsi2sdq	%rax, %xmm1
	movl	(%rbx,%r12,4), %ecx
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	movl	0(,%r13,4), %esi
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -104(%rbp)
	call	printf@PLT
	movsd	-104(%rbp), %xmm0
	leaq	.LC3(%rip), %rdi
	movb	$1, %al
	call	printf@PLT
	movq	-56(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leaq	-40(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (Arch Linux 9.3.0-1) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
