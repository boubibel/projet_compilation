.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 0
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  beqz $t0, _label_2
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  jal  sideEffect
  move $t0, $v0
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  b    _label_3
_label_2:
  li   $t0, 0
_label_3:
  bnez $t0, _label_0
  li   $t0, 0
  move $a0, $t0
  li   $v0, 1
  syscall
  b    _label_1
_label_0:
  li   $t0, 1
  move $a0, $t0
  li   $v0, 1
  syscall
_label_1:
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
sideEffect:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  li   $t0, 9
  move $a0, $t0
  li   $v0, 1
  syscall
  li   $t0, 1
  move $v0, $t0
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
