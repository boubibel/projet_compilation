.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -4
  li   $t0, 1
  # set x at offset 0
  sw   $t0, 0($sp)
  li   $t0, 1
  bnez $t0, _label_0
  b    _label_1
_label_0:
  addi $sp, $sp, -4
  li   $t0, 2
  # set x at offset 0
  sw   $t0, 0($sp)
  lw   $t0, 0($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  addi $sp, $sp, 4
_label_1:
  lw   $t0, 0($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  addi $sp, $sp, 4
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
