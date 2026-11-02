.data
    S:         .word 1, 9, 3, 4, 8, 0, 2, 8, 1, 4, 10, 9
    n:         .word 12
    grade_tab: .byte 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3
               .align 2
    hist:      .word 0, 0, 0, 0
    str_min:   .asciiz "min="
    str_max:   .asciiz " max="
    str_nl:    .asciiz "\n"
    str_g0:    .asciiz "g0="
    str_g1:    .asciiz " g1="
    str_g2:    .asciiz " g2="
    str_g3:    .asciiz " g3="
.text
.globl main
main:
    la   $a0, S
    lw   $a1, n
    jal  stats
    move $s0, $v0
    move $s1, $v1
    la   $a0, str_min
    li   $v0, 4
    syscall
    move $a0, $s0
    li   $v0, 1
    syscall
    la   $a0, str_max
    li   $v0, 4
    syscall
    move $a0, $s1
    li   $v0, 1
    syscall
    la   $a0, str_nl
    li   $v0, 4
    syscall
    la   $a0, S
    lw   $a1, n
    la   $a2, grade_tab
    la   $a3, hist
    jal  histogram
    la   $s2, hist
    la   $a0, str_g0
    li   $v0, 4
    syscall
    lw   $a0, 0($s2)
    li   $v0, 1
    syscall
    la   $a0, str_g1
    li   $v0, 4
    syscall
    lw   $a0, 4($s2)
    li   $v0, 1
    syscall
    la   $a0, str_g2
    li   $v0, 4
    syscall
    lw   $a0, 8($s2)
    li   $v0, 1
    syscall
    la   $a0, str_g3
    li   $v0, 4
    syscall
    lw   $a0, 12($s2)
    li   $v0, 1
    syscall
    li   $v0, 10
    syscall
stats:
    lw   $v0, 0($a0)
    move $v1, $v0
    addi $a0, $a0, 4
    addi $a1, $a1, -1
stats_loop:
    beq  $a1, $zero, stats_done
    lw   $t0, 0($a0)
    slt  $t1, $t0, $v0
    beq  $t1, $zero, stats_chk_max
    move $v0, $t0
stats_chk_max:
    slt  $t1, $v1, $t0
    beq  $t1, $zero, stats_next
    move $v1, $t0
stats_next:
    addi $a0, $a0, 4
    addi $a1, $a1, -1
    j    stats_loop
stats_done:
    jr   $ra
histogram:
hist_loop:
    beq  $a1, $zero, hist_done
    lw   $t0, 0($a0)
    add  $t1, $a2, $t0
    lbu  $t2, 0($t1)
    sll  $t3, $t2, 2
    add  $t3, $a3, $t3
    lw   $t4, 0($t3)
    addi $t4, $t4, 1
    sw   $t4, 0($t3)
    addi $a0, $a0, 4
    addi $a1, $a1, -1
    j    hist_loop
hist_done:
    jr   $ra