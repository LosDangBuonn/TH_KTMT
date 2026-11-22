.data
str1:       .asciiz "kien truc may tinh"
str2:       .asciiz "mips"
str3:       .asciiz ""
str4:       .asciiz "a bc def"
str5:       .asciiz "de quy can ngan xep de nho trang thai"
gach:       .asciiz "|"
xuong_dong: .asciiz "\n"
.text
.globl main
# main: goi reverse_words cho 5 chuoi kiem thu va in ket qua
# Tham so  : khong co
# Tra ve   : khong co
# Thanh ghi: $a0, $v0, $ra
main:
        la    $a0, str1
        jal   reverse_words
        la    $a0, str1
        jal   in_kq
        la    $a0, str2
        jal   reverse_words
        la    $a0, str2
        jal   in_kq
        la    $a0, str3
        jal   reverse_words
        la    $a0, str3
        jal   in_kq
        la    $a0, str4
        jal   reverse_words
        la    $a0, str4
        jal   in_kq
        la    $a0, str5
        jal   reverse_words
        la    $a0, str5
        jal   in_kq
        li    $v0, 10
        syscall
# in_kq: in chuoi giua hai dau | va xuong dong (thu tuc la)
# Tham so  : $a0 = dia chi chuoi can in
# Tra ve   : khong co
# Thanh ghi: $t0, $a0, $v0
in_kq:
        move  $t0, $a0
        li    $v0, 4
        la    $a0, gach
        syscall
        li    $v0, 4
        move  $a0, $t0
        syscall
        li    $v0, 4
        la    $a0, gach
        syscall
        li    $v0, 4
        la    $a0, xuong_dong
        syscall
        jr    $ra
# strlen: dem so ky tu truoc byte 0 (thu tuc la, khong dung ngan xep)
# Tham so  : $a0 = dia chi chuoi .asciiz
# Tra ve   : $v0 = do dai chuoi
# Thanh ghi: $t0, $t1, $v0
strlen:
        move  $t0, $a0
dem_loop:
        lbu   $t1, 0($t0)
        beq   $t1, $zero, dem_xong
        addiu $t0, $t0, 1
        j     dem_loop
dem_xong:
        subu  $v0, $t0, $a0
        jr    $ra
# rev_range: dao tai cho doan [$a0, $a1] (thu tuc la, khong dung ngan xep)
# Tham so  : $a0 = dia chi ky tu dau, $a1 = dia chi ky tu cuoi
# Tra ve   : khong co
# Thanh ghi: $t0, $t1, $t2
rev_range:
dao_loop:
        sltu  $t0, $a0, $a1
        beq   $t0, $zero, dao_xong
        lbu   $t1, 0($a0)
        lbu   $t2, 0($a1)
        sb    $t2, 0($a0)
        sb    $t1, 0($a1)
        addiu $a0, $a0, 1
        addiu $a1, $a1, -1
        j     dao_loop
dao_xong:
        jr    $ra
# reverse_words: dao thu tu cac tu tai cho (thu tuc khong la)
# Tham so  : $a0 = dia chi chuoi
# Tra ve   : khong co
# Thanh ghi: $ra, $s0, $s1 (luu trong khung 12 byte), $t0, $t1
reverse_words:
        addi  $sp, $sp, -12
        sw    $ra, 8($sp)
        sw    $s0, 4($sp)
        sw    $s1, 0($sp)
        move  $s0, $a0
        jal   strlen
        slti  $t0, $v0, 2
        bne   $t0, $zero, ket_thuc
        move  $a0, $s0
        addu  $a1, $s0, $v0
        addiu $a1, $a1, -1
        jal   rev_range
        move  $s1, $s0
duyet_chuoi:
        lbu   $t0, 0($s1)
        beq   $t0, $zero, tu_cuoi
        li    $t1, 32
        bne   $t0, $t1, ky_tu_ke
        move  $a0, $s0
        addiu $a1, $s1, -1
        jal   rev_range
        addiu $s1, $s1, 1
        move  $s0, $s1
        j     duyet_chuoi
ky_tu_ke:
        addiu $s1, $s1, 1
        j     duyet_chuoi
tu_cuoi:
        move  $a0, $s0
        addiu $a1, $s1, -1
        jal   rev_range
ket_thuc:
        lw    $s1, 0($sp)
        lw    $s0, 4($sp)
        lw    $ra, 8($sp)
        addi  $sp, $sp, 12
        jr    $ra