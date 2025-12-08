.text
  jal  main
  li   $v0, 10
  syscall
main:
  li $a0, 99
  li $v0, 1
  syscall
  jr $ra
