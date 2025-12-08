.text
  .globl main
main:
  li $v0, 4
  la $a0, str1
  syscall
  
  li $v0, 11
  li $a0, 10
  syscall
  
  li $v0, 10
  syscall
  
.data
str1:
  .asciiz "Hello"
