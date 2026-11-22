.data
n_val:  .word 20
chuoi1: .asciiz "F("
chuoi2: .asciiz ") = "
.text
.globl main
# main: doc n tu .data, goi fib_opt va in ket qua
# Tham so  : khong co
# Tra ve   : khong co
# Thanh ghi: $s0, $s1, $a0, $v0, $ra
main:
        lw    $s0, n_val
        move  $a0, $s0
        jal   fib_opt
        move  $s1, $v0
        li    $v0, 4
        la    $a0, chuoi1
        syscall
        li    $v0, 1
        move  $a0, $s0
        syscall
        li    $v0, 4
        la    $a0, chuoi2
        syscall
        li    $v0, 1
        move  $a0, $s1
        syscall
        li    $v0, 10
        syscall
# fib_opt: tinh F(n) de quy, kiem tra truong hop co so truoc khi cap khung
# Tham so  : $a0 = n (n >= 0)
# Tra ve   : $v0 = F(n)
# Thanh ghi: $ra, $s0, $s1 (luu trong khung 12 byte khi n >= 2), $t0, $a0, $v0
fib_opt:
        slti  $t0, $a0, 2
        bne   $t0, $zero, co_so
        addi  $sp, $sp, -12
        sw    $ra, 8($sp)
        sw    $s0, 4($sp)
        sw    $s1, 0($sp)
        move  $s0, $a0
        addi  $a0, $s0, -1
        jal   fib_opt
        move  $s1, $v0
        addi  $a0, $s0, -2
        jal   fib_opt
        addu  $v0, $s1, $v0
        lw    $s1, 0($sp)
        lw    $s0, 4($sp)
        lw    $ra, 8($sp)
        addi  $sp, $sp, 12
        jr    $ra

co_so:
        move  $v0, $a0
        jr    $ra