.text
main:
  addi $sp, $sp, -4
  li   $t0, 1
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  addi $sp, $sp, -4
  li   $t0, 2
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
.data
