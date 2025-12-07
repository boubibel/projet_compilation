.text
main:
  addi $sp, $sp, -4
  li   $t0, 1
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  li   $t0, 1
  bnez $t0, _label_0
  b    _label_1
_label_0:
  addi $sp, $sp, -4
  li   $t0, 2
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  # var x non trouvée
  move $a0, $t0
  li   $v0, 1
  syscall
_label_1:
  # var x non trouvée
  move $a0, $t0
  li   $v0, 1
  syscall
.data
