.text
  jal  main
  li   $v0, 10
  syscall
main:
  li   $t0, 10
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 3
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  jal  test
  addi $sp, $sp, 8
  move $t0, $v0
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  jr   $ra
test:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -4
  li   $t0, 0
  sw   $t0, 0($sp)
  b    _label_0
_label_1:
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
  sw   $t0, 12($sp)
_label_0:
  lw   $t0, 8($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 16($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sge  $t0, $t0, $t1
  bnez $t0, _label_1
  lw   $t0, 0($sp)
  move $v0, $t0
  addi $sp, $sp, 4
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
_str_0:
  .asciiz "
"
