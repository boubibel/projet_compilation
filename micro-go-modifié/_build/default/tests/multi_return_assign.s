.text
main:
  addi $sp, $sp, -8
  addi $sp, $sp, 8
f:
  li   $t0, 7
  move $v0, $t0
  jr   $ra
.data
