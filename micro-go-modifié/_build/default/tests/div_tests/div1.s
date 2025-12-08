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
  move $a0, $v0
  li   $v0, 1
  syscall
  move $a0, $v1
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
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
  lw   $t0, 12($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 20($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sub  $t0, $t0, $t1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 16($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  jal  div1
  addi $sp, $sp, 8
  sw   $v0, 0($sp)
  sw   $v1, 4($sp)
  lw   $t0, 4($sp)
  move $v1, $t0
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
  lw   $t0, 8($sp)
  move $v1, $t0
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
_str_0:
  .asciiz "\n"
