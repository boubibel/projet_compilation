.text
main:
  addi $sp, $sp, -8
  li   $t0, 1
  sw   $t0, 0($sp)
  li   $t0, 6
  sw   $t0, 4($sp)
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 0($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  sw   $t0, 0($sp)
  li   $t0, 4
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 0($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  sw   $t0, 4($sp)
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
.data
