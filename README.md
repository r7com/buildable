# Buildable

_O Buildable é um framework criação de pacotes Debian (deb)._

Sempre que preciso criar um pacote Debian para fazer a distribuição de meus projetos passava basicamente pelos mesmo problemas, criar scripts para gerar o pacote no build, fazer o script de init, e por ai vai. E isto me motivou a criar um framework para facilitar este processo e poder dedicar meu tempo ao ~~código~~ :beer:.

Sei que muitos de voces estão pensando: _Mas peraí, eu uso ruby! não seria muito mais fácil criar uma gem?_
Sim criar gem é muito mais simples, se você estiver fazendo algo para rubistas utilizarem, quando você tem uma aplicação que é direcionada ao público em geral ela é muito melhor aceita se possuir um instalador em um formato conhecido (como o Debian) :relieved:

## Como usar

Primeiramente adicione o *Buildable* no seu Gemfile

```
  group :build do
    gem 'buildable', require: false
  end
```

Execute o bundler para instalar a gem

```shell
  $ bundle install
```

Agora basta criar os arquivos de configuração do seu projeto (este passo é feito apenas uma vez)

```shell
  $ buildable init
```

Este comando criará os seguintes arquivos:

* .buildable.yml: arquivo de configuração do projeto
* production.env: arquivo de configuração do ambiente (ver: [foreman](https://github.com/ddollar/foreman))
* Procfile: arquivo de configuração do executável (ver: [foreman](https://github.com/ddollar/foreman))

O Buildable pode ser utilizado de duas formas seu executável ou via rake.

### Via bash

Para gerar o pacote basta executar o seguinte comando:

```shell
  $ buildable build
```

Quando o projeto não for um serviço, é possível desabilitar a criação do script de inicialização executando:

```shell
  $ buildable build --no-init
```

### Via rake

Para utilizar o _Buildable_ com o rake é necessário inluir o require no Rakefile

```ruby
# on Rakefile
begin
  require 'buildable/rake_task'
  Buildable::RakeTask.load
rescue LoadError
  warn "Buildable not installed!"
end

```

Para gerar o pacote basta executar


```shell
  $ bundle exec rake buildable:build
```

e para gerar o pacote sem script de inicialização

```shell
  $ bundle exec rake buildable:build -- --no-init
```

_Para uma lista completa das tasks execute rake -D_


# Dicas sujestões e agradecimentos eternos

:email: [ajfprates@gmail.com](mailto:ajfprates@gmail.com)
