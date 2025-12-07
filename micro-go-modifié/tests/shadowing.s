.text
main:
  addi $sp, $sp, -4
  li   $t0, 1
  sw   $t0, 0($sp)
  li   $t0, 1
  bnez $t0, _label_0
  b    _label_1
_label_0:
  addi $sp, $sp, -4
  li   $t0, 2
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
.data
