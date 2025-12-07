.text
main:
  addi $sp, $sp, -8
  addi $sp, $sp, 8
  li   $t0, 1
  # set: var x non trouvée
  li   $t0, 6
  # set: var y non trouvée
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var x non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  # set: var x non trouvée
  li   $t0, 4
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var x non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var y non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  # set: var y non trouvée
  # var y non trouvée
  move $a0, $t0
  li   $v0, 1
  syscall
.data
