.data
n_val:  .word 20
chuoi1: .asciiz "F("
chuoi2: .asciiz ") = "
.text
.globl main
# main: doc n tu .data, goi thu tuc tinh Fibonacci, in F(n) = <gia tri>
# Tham so  : khong co
# Tra ve   : khong co
# Thanh ghi: $s0, $s1, $a0, $v0, $ra
main:
        lw    $s0, n_val
        move  $a0, $s0
        jal   fib_rec           # doi thanh fib_iter khi do ban lap
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
# fib_rec: tinh F(n) bang de quy (thu tuc khong la)
# Tham so  : $a0 = n (n >= 0)
# Tra ve   : $v0 = F(n)
# Thanh ghi: $ra, $s0, $s1 (luu trong khung 12 byte), $t0, $a0, $v0
fib_rec:
        addi  $sp, $sp, -12
        sw    $ra, 8($sp)
        sw    $s0, 4($sp)
        sw    $s1, 0($sp)
        slti  $t0, $a0, 2
        bne   $t0, $zero, co_so
        move  $s0, $a0
        addi  $a0, $s0, -1
        jal   fib_rec
        move  $s1, $v0
        addi  $a0, $s0, -2
        jal   fib_rec
        addu  $v0, $s1, $v0
        j     thoat_fib

co_so:
        move  $v0, $a0

thoat_fib:
        lw    $s1, 0($sp)
        lw    $s0, 4($sp)
        lw    $ra, 8($sp)
        addi  $sp, $sp, 12
        jr    $ra
# fib_iter: tinh F(n) bang vong lap
# Tham so : $a0 = n    Tra ve : $v0 = F(n)
# Thanh ghi: $t0-$t3 (thu tuc la)
fib_iter:
        move  $v0, $zero        # a = F(0)
        li    $t0, 1            # b = F(1)
        move  $t1, $zero        # i = 0
fi_loop:
        slt   $t2, $t1, $a0
        beq   $t2, $zero, fi_done
        addu  $t3, $v0, $t0     # a + b
        move  $v0, $t0
        move  $t0, $t3
        addiu $t1, $t1, 1
        j     fi_loop
fi_done:
        jr    $ra