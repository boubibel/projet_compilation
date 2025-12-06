.text
main:
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _label_9
  move $a0, $t0
  li   $v0, 1
  syscall
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _label_8
  move $a0, $t0
  li   $v0, 1
  syscall
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  la   $t0, _label_7
  move $a0, $t0
  li   $v0, 1
  syscall
  # var r not found
  move $a0, $t0
  li   $v0, 1
  syscall
  la   $t0, _label_6
  move $a0, $t0
  li   $v0, 1
  syscall
div3:
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  b    _label_4
_label_5:
  # var b not found
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sub  $t0, $t0, $t1
  # set: var a not found
_label_4:
  # var b not found
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sge  $t0, $t0, $t1
  bnez $t0, _label_5
  # var r not found
  move $v0, $t0
  jr   $ra
div2:
  addi $sp, $sp, -4
  li   $t0, 0
  sw   $t0, 0($sp)
  addi $sp, $sp, 4
  b    _label_2
_label_3:
  # var b not found
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sub  $t0, $t0, $t1
  # set: var a not found
_label_2:
  # var b not found
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  sge  $t0, $t0, $t1
  bnez $t0, _label_3
  # var q not found
  move $v0, $t0
  jr   $ra
div1:
  # var b not found
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var a not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  slt  $t0, $t0, $t1
  bnez $t0, _label_0
  addi $sp, $sp, -8
  addi $sp, $sp, 8
  li   $t0, 1
  addi $sp, $sp, -4
  sw   $t0, 0($sp)
  # var x not found
  lw   $t1, 0($sp)
  addi $sp, $sp, 4
  add  $t0, $t0, $t1
  move $v0, $t0
  jr   $ra
  b    _label_1
_label_0:
  li   $t0, 0
  move $v0, $t0
  jr   $ra
_label_1:
.data
