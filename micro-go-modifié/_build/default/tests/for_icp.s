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
  # var i non trouvée
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var sum non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  # set: var sum non trouvée
  li   $t0, 1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var i non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  # set: var i non trouvée
_label_0:
  li   $t0, 5
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var i non trouvée
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  slt  $t0, $t0, $t1
  bnez $t0, _label_1
  # var sum non trouvée
  move $a0, $t0
  li   $v0, 1
  syscall
.data
