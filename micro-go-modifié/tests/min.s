.text
  jal  main
  li   $v0, 10
  syscall
main:
  li   $t0, 42
  move $a0, $t0
  li   $v0, 1
  syscall
.data
