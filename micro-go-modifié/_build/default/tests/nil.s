.text
main:
  addi $sp, $sp, -4
  addi $sp, $sp, 4
  # set: var p not found
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var p not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  seq  $t0, $t0, $t1
  bnez $t0, _label_0
  li   $t0, 1
  move $a0, $t0
  li   $v0, 1
  syscall
  b    _label_1
_label_0:
  li   $t0, 0
  move $a0, $t0
  li   $v0, 1
  syscall
_label_1:
.data
