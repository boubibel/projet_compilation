.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  li   $t0, 45
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 6
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  jal  div1
  addi $sp, $sp, 8
  move $t0, $v0
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  addi $sp, $sp, -8
  lw   $t0, 0($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_1
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  addi $sp, $sp, -4
  li   $t0, 45
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 6
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  jal  div3
  addi $sp, $sp, 8
  move $t0, $v0
  # set s at offset 0
  sw   $t0, 0($sp)
  lw   $t0, 0($sp)
  lw   $t0, 0($t0)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_1
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 0($sp)
  lw   $t0, 4($t0)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 0($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  addi $sp, $sp, 12
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
div3:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -4
  li   $a0, 8
  li   $v0, 9
  syscall
  move $t0, $v0
  # set r at offset 0
  sw   $t0, 0($sp)
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sw   $t1, 0($t0)
  b    _label_4
_label_5:
  lw   $t0, 0($sp)
  lw   $t1, 0($t0)
  addi $t1, $t1, 1
  sw   $t1, 0($t0)
  lw   $t0, 8($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 16($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sub  $t0, $t0, $t1
  # set a at offset 12
  sw   $t0, 12($sp)
_label_4:
  lw   $t0, 8($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 16($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sge  $t0, $t0, $t1
  bnez $t0, _label_5
  lw   $t0, 12($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sw   $t1, 4($t0)
  lw   $t0, 0($sp)
  move $v0, $t0
  addi $sp, $sp, 4
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
div2:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -4
  li   $t0, 0
  # set q at offset 0
  sw   $t0, 0($sp)
  b    _label_2
_label_3:
  lw   $t0, 0($sp)
  addi $t0, $t0, 1
  sw   $t0, 0($sp)
  lw   $t0, 8($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 16($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sub  $t0, $t0, $t1
  # set a at offset 12
  sw   $t0, 12($sp)
_label_2:
  lw   $t0, 8($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 16($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sge  $t0, $t0, $t1
  bnez $t0, _label_3
  lw   $t0, 0($sp)
  move $v0, $t0
  addi $sp, $sp, 4
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
div1:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  lw   $t0, 4($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 12($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  slt  $t0, $t0, $t1
  bnez $t0, _label_0
  addi $sp, $sp, -8
  li   $t0, 1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  move $v0, $t0
  addi $sp, $sp, 8
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
  addi $sp, $sp, 8
  b    _label_1
_label_0:
  li   $t0, 0
  move $v0, $t0
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
_label_1:
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
_str_1:
  .asciiz " "
_str_0:
  .asciiz "\n"
