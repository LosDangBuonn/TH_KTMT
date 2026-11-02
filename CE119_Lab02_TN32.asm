.data
    str1: .asciiz "(a+b)*[c-{d/e}]"
    str2: .asciiz "f(x[i]{j}))"
    str3: .asciiz "{[(])}"
    str4: .asciiz "((a)"
    str5: .asciiz ""
    str6: .asciiz "no brackets here"
    str7: .asciiz "]"
    str8: .asciiz "([)]"
    strP: .asciiz "([{([{([{}])}])}])"
    sep:  .asciiz " "
    nl:   .asciiz "\n"
.text
.globl main
main:
    la   $a0, strP
    jal  check_brackets
    move $s0, $v0
    move $s1, $v1
    move $a0, $s0
    li   $v0, 1
    syscall
    la   $a0, sep
    li   $v0, 4
    syscall
    move $a0, $s1
    li   $v0, 1
    syscall
    la   $a0, nl
    li   $v0, 4
    syscall
    li   $v0, 10
    syscall
check_brackets:
    move $t8, $sp
    li   $t0, 0
cb_loop:
    lbu  $t1, 0($a0)
    beq  $t1, $zero, cb_end_str
    addi $t0, $t0, 1
    addi $a0, $a0, 1
    li   $t2, 40
    beq  $t1, $t2, cb_push
    li   $t2, 91
    beq  $t1, $t2, cb_push
    li   $t2, 123
    beq  $t1, $t2, cb_push
    li   $t2, 41
    beq  $t1, $t2, cb_close_round
    li   $t2, 93
    beq  $t1, $t2, cb_close_square
    li   $t2, 125
    beq  $t1, $t2, cb_close_curly
    j    cb_loop
cb_push:
    addi $sp, $sp, -4
    sw   $t1, 0($sp)
    j    cb_loop
cb_close_round:
    li   $t3, 40
    j    cb_check_pop
cb_close_square:
    li   $t3, 91
    j    cb_check_pop
cb_close_curly:
    li   $t3, 123
cb_check_pop:
    beq  $sp, $t8, cb_err2
    lw   $t4, 0($sp)
    addi $sp, $sp, 4
    bne  $t4, $t3, cb_err1
    j    cb_loop
cb_err1:
    move $v0, $t0
    li   $v1, 1
    j    cb_exit
cb_err2:
    move $v0, $t0
    li   $v1, 2
    j    cb_exit
cb_end_str:
    bne  $sp, $t8, cb_err3
    li   $v0, 0
    li   $v1, 0
    j    cb_exit
cb_err3:
    addi $v0, $t0, 1
    li   $v1, 3
cb_exit:
    move $sp, $t8
    jr   $ra
