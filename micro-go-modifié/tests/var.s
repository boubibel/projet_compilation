.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -8
  li   $t0, 1
  # set x at offset 0
  sw   $t0, 0($sp)
  li   $t0, 6
  # set y at offset 4
  sw   $t0, 4($sp)
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  # set x at offset 0
  sw   $t0, 0($sp)
  li   $t0, 4
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 8($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  # set y at offset 4
  sw   $t0, 4($sp)
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  addi $sp, $sp, 8
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
_ampopen:
  .asciiz "&{"
_close:
  .asciiz "}"
_space:
  .asciiz " "
