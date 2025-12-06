.text
main:
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 0
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  and  $t0, $t0, $t1
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
sideEffect:
  li   $t0, 9
  move $a0, $t0
  li   $v0, 1
  syscall
  li   $t0, 1
  move $v0, $t0
  jr   $ra
.data
