module Buildable
  class Generator
    attr_reader :name, :package_name

    def initialize(name)
      @name = name
      @package_name = name.gsub('_', '-')
    end

    def create(template, destination)
      @template = File.read(template)
      content = ERB.new(@template).result binding
      File.open(destination, 'w') { |f| f.write content }
    end
  end
end