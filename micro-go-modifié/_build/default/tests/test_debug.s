.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  li   $t0, 7
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 3
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  jal  test
  addi $sp, $sp, 8
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
  la   $t0, _str_1
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 8($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_2
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  addi $sp, $sp, -8
  lw   $t0, 16($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 16($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  jal  ret
  addi $sp, $sp, 8
  sw   $v0, 0($sp)
  sw   $v1, 4($sp)
  la   $t0, _str_3
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 0($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_4
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  la   $t0, _str_5
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 16($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_6
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 12($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 8($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 12($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 8($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  move $v1, $t0
  lw   $t0, 16($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  move $v0, $t0
  addi $sp, $sp, 8
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
ret:
  addi $sp, $sp, -4
  sw   $ra, 0($sp)
  la   $t0, _str_7
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 8($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_2
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 4($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _str_0
  move $a0, $t0
  li   $v0, 4
  syscall
  lw   $t0, 4($sp)
  move $v1, $t0
  lw   $t0, 8($sp)
  move $v0, $t0
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra
.data
_str_7:
  .asciiz "ret: a="
_str_6:
  .asciiz " y+b="
_str_5:
  .asciiz "test: x+a="
_str_4:
  .asciiz " y="
_str_3:
  .asciiz "test: x="
_str_2:
  .asciiz " b="
_str_1:
  .asciiz "test: a="
_str_0:
  .asciiz "\n"
