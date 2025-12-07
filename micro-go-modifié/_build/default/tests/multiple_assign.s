.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  li   $t0, 1
  sw   $t0, 0($sp)
  addi $sp, $sp, -4
  li   $t0, 2
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 0($sp)
  sw   $t0, 12($sp)
  lw   $t0, 4($sp)
  sw   $t0, 8($sp)
  addi $sp, $sp, 8
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  lw   $t0, 0($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  jr   $ra
.data
