; Exemplo de um Programa do Tipo Hello World compilado com NASM 64-bits para Windows e Linkado com GoLink ou com o Link do Visual Studio.
; Nesse exemplo é usada a função WriteConsoleA da API do windows WriteConsoleA para imprimir a mensagem na saída do console.
; É necessário usar a função GetStdHandle para pegar a saída padrão do console.
; Por fim, é usado a função ExitProcess para finalizar o programa.
;
; Compilar:
; nasm -f win64 main.asm
;
; Linkar com o GoLink:
; GoLink.exe  /console /entry start main.obj kernel32.dll
; 
; Linkar com o Visual Studio:
; vsexec.bat
; link /entry:start /subsystem:console main.obj kernel32.lib

; Importando as Funções da API do Windows que estão dentro da biblioteca kernel.dll, kernel.lib.
extern GetStdHandle     ; Obter a Saída Padrão do Console.
extern WriteConsoleA    ; Imprimir texto no console usando ANSI.
extern ExitProcess      ; Finalizar o Processo Atual.


; Seção de Dados onde são Definidas as Constantes (Read-Only Data)
section .rodata
    msg db "Hello World!", 0x0d, 0x0a   ; Mensagem mais os caracteres: 0x0D Byte do Carriage Return \r. 0x0A Byte de Retorno do New Line \n.
    msg_len equ $ - msg                 ; Pego o tamanho da msg. (endereço atual "$" menos o endereço da última letra de "msg").
    stdout_query equ -11                ; Parâmetro do GetStdHandle para pegar a Saída Padrão (-11), Entrada Padrão (-10) ou Erro Padrão (-12).
    status equ 0                        ; Status de Retorno do Programa usado por ExitProcess, 0 significa Finalizado com Sucesso.


; Seção de Dados onde são Definidas as Variáveis e Estruturas de Dados
section .data
    stdout dw 0         ; Identificador do Console retornado pela função GetStdHandle, usado como parâmetro do WriteConsoleA
    bytesWritten dw 0   ; Parâmetro de WriteConsoleA usado para informar a Quantidade de Bytes Gravados


; Seção onde o Código do Programa é Armazenado
section .text
    global start    ; Definindo o símbolo "start" como ponto de entrada padrão do nosso programa.


start:
    ; Estas três linhas chamam a função GetStdHandle e armazenam o "handle" da saída padrão na variável "stdout"
    ; Para setar os parâmetros das APIs do Windows, é necessário colocar os valores em registradores específicos
    ; Por exemplo: para setar o parâmetro da função GetStdHandle, deve usar o Registro RCX
    ; Assim como para pegar o valor de retorno dessas funções, também se usam registradores específicos
    mov rcx, stdout_query   ; Move o valor da constante "stdout_query" para o registrador RCX
    call GetStdHandle       ; Chama a função GetStdHandle
    mov [rel stdout], rax   ; Move o valor retornado, que foi armazenado no registrador RAX, para a variável "stdout"

    ; Essas Linhas chamam a função WriteConsoleA para escrever a mensagem "Hello World!" no Console
    mov  rcx, [rel stdout]  ; Move o Valor da Variável "stdout" para o RCX, primeiro argumento da função WriteConsoleA.
    mov  rdx, msg           ; Move o endereço da string "msg" para o registrador RDX, que é o segundo argumento da função WriteConsoleA.
    mov  r8, msg_len        ; Move o valor da constante "msg_len" para o registrador R8, terceiro argumento da função WriteConsoleA.
    mov  r9, bytesWritten   ; Move o endereço da variável "bytesWritten" para o registrador R9, quarto argumento da função WriteConsoleA.
    push qword 0            ; Quinto argumento da função WriteConsoleA, ele é um parâmetro reservado e seu valor deve ser passado zerado
                            ; para não pegar outro valor que possa estar na pilha e causar comportamentos indesejados.
                            ; Parâmetros reservados são parâmetros que não são utilizado no momento pela função, mas que podem ser usados no futuro.
    call WriteConsoleA      ; Chama a função WriteConsoleA para imprimir a mensagem na saída padrão.

    ; Essas duas últimas linhas servem para finalizar o programa
    mov rcx, status     ; Move o valor do código de status do programa para RCX, parâmetro da função ExitProcess.
    call ExitProcess    ; Chama a função ExitProcess para finalizar o programa.