.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -4
  jal  makeRes
  move $t0, $v0
  # set r at offset 0
  sw   $t0, 0($sp)
  lw   $t0, 0($sp)
  lw   $t0, 0($t0)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 0($sp)
  lw   $t0, 4($t0)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_1
  move $a0, $t0
  li   $v0, 4
  syscall
  addi $sp, $sp, 4
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
makeRes:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  addi $sp, $sp, -4
  li   $a0, 8
  li   $v0, 9
  syscall
  move $t0, $v0
  # set r at offset 0
  sw   $t0, 0($sp)
  li   $t0, 7
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sw   $t1, 0($t0)
  li   $t0, 3
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sw   $t1, 4($t0)
  lw   $t0, 0($sp)
  move $v0, $t0
  addi $sp, $sp, 4
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
_str_1:
  .asciiz "\n"
_str_0:
  .asciiz " "
