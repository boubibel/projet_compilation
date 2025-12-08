.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  li   $t0, 42
  move $a0, $t0
  li   $v0, 1
  syscall
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
