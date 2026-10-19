# MSSV: 25520506 (a = 6, b = 0)
# Vai tro thanh ghi:
#   $s0: Dien nang con lai chua tinh tien (kWh)
#   $s1: Tong tien dien (dong)
#   $s2: Can duoi cua bac hien tai (kWh)
#   $s3: Con tro vao mang nguong
#   $s4: Con tro vao mang don_gia
        .data
tb_nhap: .asciiz "Nhap so kWh (0..9999): "
tb_loi:  .asciiz "Gia tri khong hop le, nhap lai.\n"
tb_xuat: .asciiz "Tien dien: "
don_vi:  .asciiz " dong\n"
        .align 2
nguong:  .word 50, 100, 200, 300, 400, 9999
don_gia: .word 1720, 1780, 2070, 2620, 2970, 3120
        .text
        .globl main
main:
vong_nhap:
        la    $a0, tb_nhap
        li    $v0, 4
        syscall
        li    $v0, 5
        syscall
        move  $s0,$v0
        sltiu $t0,$s0, 10000
        bne   $t0,$zero, hop_le
        la    $a0, tb_loi
        li    $v0, 4
        syscall
        j     vong_nhap
hop_le:
        li    $s1, 0
        li    $s2, 0
        la    $s3, nguong
        la    $s4, don_gia
vong_bac:
        beq   $s0,$zero, hoan_tat
        lw    $t0, 0($s3)
        lw    $t1, 0($s4)
        subu  $t2, $t0,$s2
        slt   $t3, $s0,$t2
        beq   $t3,$zero, tinh_tien
        move  $t2,$s0
tinh_tien:
        mul   $t4, $t2,$t1
        addu  $s1, $s1,$t4
        subu  $s0, $s0,$t2
        move  $s2,$t0
        addiu $s3,$s3, 4
        addiu $s4,$s4, 4
        j     vong_bac
hoan_tat:
	la   $a0, tb_xuat
        li   $v0, 4
        syscall
        move $a0, $s1
        li   $v0, 1
        syscall
        la   $a0, don_vi
        li   $v0, 4
        syscall
        li   $v0, 10
        syscall