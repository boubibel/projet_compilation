.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -4
  li   $t0, 0
  # set sum at offset 0
  sw   $t0, 0($sp)
  addi $sp, $sp, -4
  li   $t0, 0
  # set i at offset 0
  sw   $t0, 0($sp)
  b    _label_0
_label_1:
  lw   $t0, 0($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 8($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  # set sum at offset 4
  sw   $t0, 4($sp)
  li   $t0, 1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  # set i at offset 0
  sw   $t0, 0($sp)
_label_0:
  li   $t0, 5
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  slt  $t0, $t0, $t1
  bnez $t0, _label_1
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  addi $sp, $sp, 8
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
