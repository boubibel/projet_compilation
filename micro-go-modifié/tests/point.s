.text
main:
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  move $a0, $t0
  li   $v0, 1
  syscall
.data
