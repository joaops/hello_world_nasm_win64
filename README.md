# Hello World em Assembly NASM para Windows 64-bits

Exemplo de um programa do tipo "Hello World!" escrito em Assembly NASM para Windows 64-bits e linkado com GoLink ou com o Visual Studio.

## Configuração do Ambiente de Desenvolvimento

Para poder criar o executável é necessário instalar o Montador `NASM`, que traduz o código assembly para o código objeto. Também é necessário instalar um Linkador, que irá converter o código objeto para um arquivo executável. Existem dois linkadores que você pode usar, o `GoLink` ou o `Link` do Visual Studio, qualquer um dos dois pode ser usado para gerar o executável.

### Instalação do NASM 64-bits

Acesse o site do [NASM](https://www.nasm.us/), clique no Menu **Download**, clique na versão mais recente e depois na pasta **win64**, então baixe o executável e instale como ele **Administrador**.

O instalador irá mostrar duas opções,  **Install for anyone using this computer** e **Install just for me**, a diferença é que na primeira, os arquivos serão instalados no diretório `C:\Program Files\NASM`, enquanto que na segunda, será instalado no diretório do usuário `C:\Users\seu nome do seu usuário\AppData\Local\bin\NASM`.

Escolha a primeira opção e prosiga com a instalação.

Agora clique no **Iniciar do Windows**, digite **variáveis** e abra a janela de **Propriedades do Sistema**. Na Aba **Avançado**, cliqu no botão **Variáveis de Ambiente...**. Dentro do Grupo **Variáveis do sistema**, edite a variável **Path** e adicione o diretório de instalação do NASM: `C:\Program Files\NASM`.

Caso você tenha escolhido instalar apenas para o seu usuário, escolha o grupo **Variáveis de usuário para ...**, então edite a variável **Path** e adicione o diretório `C:\Users\seu nome de usuário\AppData\Local\bin\NASM`. Clique em **OK** para salvar a alteração.

Para testar, abra o **Prompt de Comando** e execute o comando `nasm -v`, a saída deverá ser similar a:

```
NASM version 2.16.01 compiled on Dec 21 2022
```

### Instalação do GoLink

Acesse o site [Go Dev Tools](https://www.godevtool.com/), Localize a seção do `Linker` e baixe o `GoLink.exe`. Não se preocupe, o site é feio mesmo.

Extraia os arquivos do `Golink.zip` dentro do diretório `C:\Program Files\GoLink` ou em qualquer outro diretório que você quiser.

Assim como no NASM, adicione o diretório do GoLink `C:\Program Files\GoLink` nas variável de ambiente `Path`.

### Instalação do Visual Studio Community

Acesse o site do [Visual Studio](https://visualstudio.microsoft.com/pt-br/downloads/) e baixe o instalador do Community.

Durante a instalação, selecione o módulo `Desenvolvimento para desktop com C++` que está na categoria `Área de trabalho e Dispositivos móveis`, o linkador que vamor utilizar está dentro desse módulo.

Clique no botão `Instalar` e aguarde a inatalação.

Ao terminar a instalação, será mostrado uma tela para entrar com a sua `Conta da Microsoft`, você pode `Entrar` ou então `Ignore isso por enquanto`.

Com isso o Visual Studio já estará instalado, so você quiser, pode criar um projeto em brando só para testar, mas não é necessário.

#### Criando um Hello World em C++ para Testar o Visual Studio

Clique em `Criar um projeto`, depois em `Projeto Vazio`, escolha o `Nome do projeto` e o `Local`, por fim clique em `Criar`.

Feche a janela de Notas de Versão.

Clique com o `Botão Direito do Mouse` no `Nome do Projeto`, depois em `Adicionar` e `Novo Item...`.

Nomeie o arquivo para `Main.cpp` e clique em `Adicionar`.

Copie o seguinte código fonte nele:

```cpp
#include <iostream>

using namespace std;

int main() {
	cout << "Hello, World!" << endl;
	return 0;
}
```

Por fim, clique a Tecla `F5` para compilar e executar o programa.

Você deverá ver a seguinte saída:

```bash
Hello, World!
```

Após isso, feche o Console de Saída, o Visual Studio e o Visual Studio Installer.

## Compilando o Programa com NASM para Windows 64-bits

Abra o Prompt de Comando e Navegue até o diretório do projeto, onde está o arquivo `main.asm`.

Execute o seguinte comando:

```bash
nasm -f win64 main.asm
```

> o parâmetro **-f** significa **format**, que recebe o valor **win64**, para compilar o programa para Windows 64-bits

Se não houver erros de compilação, esse comando irá gerar o arquivo objeto `main.obj` no mesmo diretório do código fonte.

## Linkando com o GoLink.exe

Após compilar o arquivo objeto, o próximo passo é linkar para um arquivo executável, e para isso, pode ser usado o Golink.exe ou o Visual Studio.

A vantagem de usar o GoLink é que ele é estramamente pequeno, o seu executável tem apenas alguns kilosbytes de tamanho e não precisa fazer uma instalação complexa como é feito com o Visual Studio.

Para linkar, abra o `Prompt de Comando` e `Navege` até o diretório do `Arquivo Objeto`.

Então execute o seguinte comando:

```bash
GoLink.exe  /console /entry start main.obj kernel32.dll
```

> **/console**: é uma opção que especifica que o programa será executado em modo console.

> **/entry start**: é uma opção que especifica o ponto de entrada do programa, que nesse caso é a função **start**.

> **main.obj**: é o arquivo objeto gerado pelo compilador NASM.

> **kernel32.dll**: é a biblioteca padrão do Windows que contém funções essenciais do sistema usadas no programa, como o **GetStdHandle**, **WriteConsoleA** e o **ExitProcess**.

Caso ocorra tudo certo, será gerado o arquivo `main.exe` no mesmo diretório do Arquivo Objeto.

Para executar o programa, chame o seu executável pelo Prompt de Comando:

```bash
main.exe
```

Você verá a seguinte saída:

```bash
Hello World!
```

## Linkando com o Visual Studio

Linkar o `Arquivo Objeto` para o `Arquivo Executável` é um pouso diferente no Visual Studio, antes de poder executar o comando de linkagem, é necessário inicializar o ambiente para 64-bits no seu Prompt de Comando.

### Usando o Prompt de Comando do Visual Studio

Uma forma de fazer isso é usando o `Prompt de Comando` já inicializado com as variáveis de ambiente que foi configurado durante a instalação do Visual Studio.

Para isso, clique no `Menu Iniciar do Windows` e digite `x64 Native Tools Command Prompt for VS 2022`, então aperte enter `Prompt de Comando`.

Com o Prompt de Comando aberto, `Navege` até o diretório do `Arquivo Objeto` e execute o seguinte comando:

```bash
link /entry:start /subsystem:console main.obj kernel32.lib
```

> **/entry:start**: é uma opção que especifica o ponto de entrada do programa, que nesse caso é a função **start**.

> **/subsystem:console**: é uma opção que especifica que o programa será executado em modo console.

> **main.obj**: é o arquivo objeto gerado pelo compilador NASM.

> **kernel32.lib**: é a biblioteca padrão do Windows que contém funções essenciais do sistema usadas no programa, como o **GetStdHandle**, **WriteConsoleA** e o **ExitProcess**.

Caso ocorra tudo certo, será gerado o arquivo `main.exe` no mesmo diretório do Arquivo Objeto.

Para executar o programa, chame o seu executável pelo Prompt de Comando:

```bash
main.exe
```

Você verá a seguinte saída:

```bash
Hello World!
```

> É possível Iniciar o **VS Code** usando o Prompt de Comando do Visual Studio, ao fazer isso será possível usar o comando **link** pelo **Terminal** do próprio **VS Code**. Apenas navegue até o diretório do projeto e execute o comando **code .** usando o **Prompt de Comando** do Visual Studio.

### Inicializando um Prompt de Comando

Ao invez de usar o Prompt de Comando que foi configurado pelo Visual Studio durante sua instalação, é possível inicializar esse ambiente de desenvolvimento em um outro Prompt de Comando. Essa é uma opção mais prática, pois é possível inicializar esse ambiente dentro do Terminal do VS Code e por meio de um arquivo `.bat`.

Para isso, crie o arquivo `vsexec.bat` com o seguinte conteúdo:

```bash
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64 %*
```

Antes de executar o comando de linkagem, execute primeiro o arquivo `vsexec.bat` por uma janela de um `Prompt de Comando` ou pelo `Terminal` do VS Code.

```bash
vsexec.bat
```

Em seguida, execute o comando de linkagem:

```bash
link /entry:start /subsystem:console main.obj kernel32.lib
```

> **/entry:start**: é uma opção que especifica o ponto de entrada do programa, que nesse caso é a função **start**.

> **/subsystem:console**: é uma opção que especifica que o programa será executado em modo console.

> **main.obj**: é o arquivo objeto gerado pelo compilador NASM.

> **kernel32.lib**: é a biblioteca padrão do Windows que contém funções essenciais do sistema usadas no programa, como o **GetStdHandle**, **WriteConsoleA** e o **ExitProcess**.

Caso ocorra tudo certo, será gerado o arquivo `main.exe` no mesmo diretório do Arquivo Objeto.

Para executar o programa, chame o seu executável pelo Prompt de Comando:

```bash
main.exe
```

Você verá a seguinte saída:

```bash
Hello World!
```
