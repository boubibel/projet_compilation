.text
main:
  addi $sp, $sp, -4
  li   $t0, 1
  sw   $t0, 0($sp)
  lw   $t0, 0($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
.data
