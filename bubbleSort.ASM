
 format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable


start:

mov ebx, [n]
push ebx

push arr

call bubbleSort
call printArray


exist:

   invoke ExitProcess, 0;


bubbleSort:
        push ebp
        mov ebp,esp
        mov ebx ,[ebp+12]; size
        mov ecx , [ebp+8] ; array
        mov [i] , 0
        mov edx , ebx
        sub edx ,1

   outer_loop_start:
        cmp [i] , edx
        jge outer_loop_end
        mov [j] ,0
   inner_loop_start:
        sub edx ,[i]
        cmp [j] , edx
        jge inner_loop_end
        mov esi , [j]
        mov edx , [ecx+esi*4]
        mov edi ,[ecx+esi*4+4]

       push edx
       push edi
       call compare
       pop edi
       pop edx
       cmp eax , 0

       je end_if_condition
       jg continue
  continue:
        mov edx,[ecx + esi*4]
        mov [ecx+esi*4],edi
        mov [ecx+esi*4+4],edx
        jmp end_if_condition
   end_if_condition:
       add [j],1
       mov edx,ebx
       sub edx ,1
       jmp inner_loop_start
    inner_loop_end:
        add[i],1
       mov edx,ebx
       sub edx ,1
        jmp  outer_loop_start
    outer_loop_end:

     ;mov esp , ebp
     pop ebp
     ret


compare:
push ebp
mov ebp, esp
mov edx,[ebp+12]
mov eax, [ebp+8]
cmp eax, edx
jg .L1
jl .L2
je .L3


.L1:
mov eax,1
jmp end_compare

.L2:
mov eax,0
jmp end_compare

.L3:
mov eax,0

end_compare:
;mov esp, ebp
pop ebp
ret

printArray:
   push ebp
   mov ebp, esp
   mov ecx, [ebp+12]
   mov ebx, [ebp+8]
   mov esi ,0
   mov eax ,0
   printloop:
     push ecx
      mov eax , [ebx +esi*4]
     cinvoke printf, f1, eax
     add esi , 1
     pop ecx
     loop printloop
     cinvoke scanf, f6, x
     mov esp , ebp
     pop ebp
    ret


section '.data' data readable writeable
arr dd 5,8,11,7,10,4,1,9
n dd 8
f1 db ' %d',0
f6 db '%d',0
i dd 0
j dd 0
x dd ?



section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'