module Buildable
  class Generator
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def create(template, destination)
      @template = File.read(template)
      content = ERB.new(@template).result binding
      File.open(destination, 'w') { |f| f.write content }
    end

  end
end