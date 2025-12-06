.text
main:
  addi $sp, $sp, -4
  li   $t0, 0
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  addi $sp, $sp, -4
  li   $t0, 0
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  b    _label_0
_label_1:
  # var i not found
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var sum not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  # set: var sum not found
  li   $t0, 1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var i not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  # set: var i not found
_label_0:
  li   $t0, 5
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var i not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  slt  $t0, $t0, $t1
  bnez $t0, _label_1
  # var sum not found
  move $a0, $t0
  li   $v0, 1
  syscall
.data
