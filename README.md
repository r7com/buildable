# Buildable

_O Buildable é um framework criação de pacotes Debian (deb)._

Sempre que preciso criar um pacote Debian para fazer a distribuição de meus projetos passava basicamente pelos mesmo problemas, criar scripts para gerar o pacote no build, fazer o script de init, e por ai vai. E isto me motivou a criar um framework para facilitar este processo e poder dedicar meu tempo ao ~~código~~ :beer:. 

Sei que muitos de voces estão pensando: _Mas peraí, eu uso ruby! não seria muito mais fácil criar uma gem?_
Sim criar gem é muito mais simples, se você estiver fazendo algo para rubistas utilizarem, quando você tem uma aplicação que é direcionada ao público em geral ela é muito melhor aceita se possuir um instalador em um formato conhecido (como o Debian) :relieved:

## Como usar

Primeiramente adicione o *Buildable* no seu Gemfile

```
  gem 'buildable'
```

Execute o bunlder para instalar a gem

```shell
  $ bundle install
```

Agora basta criar os arquivos de configuração do seu projeto (este passo é feito apenas uma vez)

```bash
  $ buildable init
```

Este comando criará os seguintes arquivos:

#TO BE CONTINUED


O Buildable pode ser utilizado de duas formas seu executável ou via rake (ideal para automatização do build), 

# Dicas sujestões e agradecimentos eternos

:email: [ajfprates@gmail.com](mailto:ajfprates@gmail.com)
