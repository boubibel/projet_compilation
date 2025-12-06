.text
main:
  addi $sp, $sp, -12
  addi $sp, $sp, 12
  li   $t0, 2
  # set: var a not found
  li   $t0, 9
  # set: var n not found
  li   $t0, 1
  # set: var acc not found
  b    _label_0
_label_1:
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var n not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  rem  $t0, $t0, $t1
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  bnez $t0, _label_2
  b    _label_3
_label_2:
  # var acc not found
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  # set: var acc not found
_label_3:
  # var a not found
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  # set: var a not found
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var n not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  div  $t0, $t0, $t1
  # set: var n not found
_label_0:
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var n not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  bnez $t0, _label_1
  # var acc not found
  move $a0, $t0
  li   $v0, 1
  syscall
.data
