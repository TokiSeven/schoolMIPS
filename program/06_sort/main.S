;Сортировка Шелла
;для массива слов (word)
;на входе
; ds:dx - адрес массива слов (word)
; cx    - длина массива
ShellsSort      proc
        mov     bx,     dx      ;bx - адрес массива
        mov     dx,     cx      ;dx - длина масива
 
        shl     dx,     1       ;для удобства приведём индекс к размерности элемента
        ;for(k = N/2; k > 0; k /=2)
@@ForK:
        shr     cx,     1       ;k/=2
        jcxz    @@BreakK        ;k>0
        ;       for(i = k; i < N; i++)
        shl     cx,     1       ;для удобства приведём индекс к размерности элемента
        mov     si,     cx      ;i=k
@@ForI:
        ;               t=A[i]
        mov     ax,      [bx+si]
        ;               for(j = i; j>=k; j-=k)
        mov     di,     si              ;j=i
        push    si
        sub     si,     cx
        @@ForJ:
        ;                       if(t < A[j-k])
                cmp     ax,     [bx+si]
                jge     @@BreakJ
                push    ax
                mov     ax,     [bx+si] ;ax=A[j-k]
                mov     [bx+di],ax      ;A[j]=A[j-k]
                pop     ax
 
                sub     di,     cx      ;j-=k
                sub     si,     cx
                cmp     di,     cx      ;j>=k
                jae     @@ForJ
        @@BreakJ:
        pop     si
        ;               A[j]=t
        mov     [bx+di],        ax
        add     si,     2       ;i++ (т.к. размер элемента массива равен 2)
        cmp     si,     dx      ;i<N
        jb      @@ForI
        shr     cx,     1       ;возвращение значения cx
 
        jmp     @@ForK
@@BreakK:
        ret
ShellsSort      endp