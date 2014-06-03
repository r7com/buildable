require "./lib/buildable/version"
require "./lib/buildable/generator"

module Buildable
  class << self

    def run(name)
      create_directories
      create_files(name)
    end

    private

    def create_directories
      p from_here './build'
      # File.mkdir(from_here './build')
      # File.mkdir(from_here './build/debian')
      # File.mkdir(from_here './etc')
      # File.mkdir(from_here './etc/init.d')
    end

    def create_files(name)
      # templates =
      # generator = Buildable::Generator.new(name)
      # generator
    end

    def from_here(dir)
      File.expand_path(dir)
    end

  end
end
