.text
  jal  main
  li   $v0, 10
  syscall
main:
  addi $sp, $sp, -12
  li   $t0, 2
  sw   $t0, 0($sp)
  li   $t0, 9
  sw   $t0, 4($sp)
  li   $t0, 1
  sw   $t0, 8($sp)
  b    _label_0
_label_1:
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 12($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  rem  $t0, $t0, $t1
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  bnez $t0, _label_2
  b    _label_3
_label_2:
  lw   $t0, 8($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  sw   $t0, 8($sp)
_label_3:
  lw   $t0, 0($sp)
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 4($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  mul  $t0, $t0, $t1
  sw   $t0, 0($sp)
  li   $t0, 2
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 8($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  div  $t0, $t0, $t1
  sw   $t0, 4($sp)
_label_0:
  li   $t0, 0
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  lw   $t0, 8($sp)
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sne  $t0, $t0, $t1
  bnez $t0, _label_1
  lw   $t0, 8($sp)
  move $a0, $t0
  li   $v0, 1
  syscall
.data
