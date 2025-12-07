.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -8
  lw   $t0, 0($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  jr   $ra
f:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  li   $t0, 7
  move $v0, $t0
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
