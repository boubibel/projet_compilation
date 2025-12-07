.text
main:
  addi $sp, $sp, -12
  addi $sp, $sp, 12
  li   $t0, 2
  # set: var a non trouvée
  li   $t0, 9
  # set: var n non trouvée
  li   $t0, 1
  # set: var acc non trouvée
  b    _label_0
_label_1:
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var n non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  rem  $t0, $t0, $t1
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  bnez $t0, _label_2
  b    _label_3
_label_2:
  # var acc non trouvée
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  # set: var acc non trouvée
_label_3:
  # var a non trouvée
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  # set: var a non trouvée
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var n non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  div  $t0, $t0, $t1
  # set: var n non trouvée
_label_0:
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var n non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  bnez $t0, _label_1
  # var acc non trouvée
  move $a0, $t0
  li   $v0, 1
  syscall
.data
