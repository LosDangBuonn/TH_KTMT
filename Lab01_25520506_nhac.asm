# MSSV: 25520506 (a = 6, b = 0)
# Vai tro thanh ghi:
#   $s0: Con tro mang cao_do
#   $s1: Con tro mang do_dai
#   $s2: Tong so not nhac (15)
#   $s3: Bien dem not hien tai
#   $s4: Tong thoi gian du kien (ms)
#   $s5: Moc thoi gian bat dau va thoi gian do duoc (ms)
#   $s6: Cao do thuc te cua not dang phat
#   $s7: Thoi luong (ms) cua not dang phat
        .data
cao_do:         .word 64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62
do_dai:         .word 2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  3,  1,  4
so_not:         .word 15
khoang_trang:   .asciiz " "
xuong_dong:     .asciiz "\n"
tb_du_kien:     .asciiz "Tong du kien (ms): "
tb_do_duoc:     .asciiz "Thoi gian do duoc (ms): "
        .text
        .globl main
main:
        la   $s0, cao_do
        la   $s1, do_dai
        lw   $s2, so_not
        li   $s3, 0
        li   $s4, 0
        li   $v0, 30
        syscall
        move $s5, $a0
vong_lap_phat:
        beq  $s3, $s2, ket_thuc_phat
        lw   $t0, 0($s0)
        addiu $s6, $t0, 6
        lw   $t1, 0($s1)
        li   $t2, 150
        mul  $s7, $t1, $t2
        addu $s4, $s4, $s7
        move $a0, $s6
        li   $v0, 1
        syscall
        la   $a0, khoang_trang
        li   $v0, 4
        syscall
        move $a0, $s7
        li   $v0, 1
        syscall
        la   $a0, xuong_dong
        li   $v0, 4
        syscall
        move $a0, $s6
        move $a1, $s7
        li   $a2, 0
        li   $a3, 100
        li   $v0, 33
        syscall
        addiu $s0, $s0, 4
        addiu $s1, $s1, 4
        addiu $s3, $s3, 1
        j    vong_lap_phat
ket_thuc_phat:
        li   $v0, 30
        syscall
        subu $s5, $a0, $s5
        la   $a0, tb_du_kien
        li   $v0, 4
        syscall
        move $a0, $s4
        li   $v0, 1
        syscall
        la   $a0, xuong_dong
        li   $v0, 4
        syscall
        la   $a0, tb_do_duoc
        li   $v0, 4
        syscall
        move $a0, $s5
        li   $v0, 1
        syscall
        la   $a0, xuong_dong
        li   $v0, 4
        syscall
        li   $v0, 10
        syscall