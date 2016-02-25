# Buildable

O Buildable é uma gem para facilitar a criação de pacotes Debian (deb).

Durante muito tempo observei o quanto era trabalhoso para os desenvolvedores criarem scripts

para realizar o processo de "build" de suas aplicações, eles sempre passando por basicamente

os mesmos problemas e _reinventando_ _a_ _roda_ a cada novo projeto. Isto me motivou a

escrever uma gem que pudesse de forma simples resolver este problema e fosse versátil o

suficiente para se adaptar a todas as peculiaridades de cada projeto possui. E foi assim

que o Buildable nasceu com a premissa de facilitar o processo de criação de projetos deixando

o desenvolvedor livre para se preocupar com o que lhe interessa ~~o código~~ :beer:.


## Como usar

O Buildable deve ser incluido como dependência do projeto (Gemfile), uma vez instalado ele

disponibiliza duas formas de uso, a primeira via seu executável (shell) e a segunda via

task no Rake (opção padrão usada no jenkins de produção). A utilização do Rake é um dos

grandes trunfos deste projeto pois com ele o desenvolvedor pode criar _tasks_ para atender

a qualquer necessidade que o seu projeto tenha antes de ser empacotado.


### Adicionando gem

### Criando configs

### Configurando como subir a aplicação

### Configurando o Rake

## Criando pacote local

# Dicas sujestões e agradecimentos eternos

:email: [ajfprates@gmail.com](mailto:ajfprates@gmail.com)
