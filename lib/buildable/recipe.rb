require 'fileutils'

module Buildable::Recipe
  class << self
    @@recipes = {}

    def [](name)
      @@recipes[name].call if @@recipes.has_key?(name)
    end

    def recipe(name, &block)
      @@recipes[name] = block
    end
  end
end

dir = File.expand_path('../recipes/*.rb', __FILE__)
Dir[dir].each { |source| require source }