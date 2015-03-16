module Buildable::Recipe
  recipe :init do
    puts "Creating Procfile"
    Buildable::FileMaker.template 'Procfile'
    puts "Creating .buildable.yml"
    Buildable::FileMaker.template '.buildable.yml'
    puts "Please edit .buildable.yml to setup application"
  end
end