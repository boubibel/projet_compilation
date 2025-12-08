.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  jal  test
  move $t0, $v0
  move $a0, $v0
  li   $v0, 1
  syscall
  move $a0, $v1
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
test:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -8
  li   $t0, 7
  # set x at offset 0
  sw   $t0, 0($sp)
  li   $t0, 3
  # set y at offset 4
  sw   $t0, 4($sp)
  lw   $t0, 4($sp)
  move $v1, $t0
  lw   $t0, 0($sp)
  move $v0, $t0
  addi $sp, $sp, 8
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
_str_0:
  .asciiz "\n"
_ampopen:
  .asciiz "&{"
_close:
  .asciiz "}"
_space:
  .asciiz " "
