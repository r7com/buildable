require "buildable/version"
require "buildable/generator"

require 'fileutils'
require 'erb'

module Buildable
  class << self

#
#
#  REMEMBER to adding fpm to Gemfile
#
#
    def run(name)
      create_directories
      create_files(name)
      check_dependencies if File.exist? gemfile_path
    end

    private

    def create_directories
      create_dir File.expand_path('./build')
      create_dir File.expand_path('./build/debian')
      create_dir File.expand_path('./etc')
      create_dir File.expand_path('./etc/init.d')
    end

    def create_files(name)
      generator = Buildable::Generator.new(name)
      templates.each do |template|
        destination = File.expand_path('.' + template.sub(template_path, '').sub('.erb', ''))
        generator.create template, destination
      end

      FileUtils.chmod '+x', File.expand_path('./etc/init.d/init.d')
      FileUtils.mv File.expand_path('./etc/init.d/init.d'), File.expand_path("./etc/init.d/#{name}")
    end

    private

    def create_dir(dir)
      FileUtils.mkdir dir unless File.exist? dir
    end

    def templates
      @templates ||= Dir[File.expand_path('**/*.erb', template_path)]
    end

    def template_path
      @template_path ||= File.expand_path('../../templates', __FILE__)
    end

    def gemfile_path
      File.expand_path('./Gemfile')
    end

    def check_dependencies
      gemfile = File.read gemfile_path
      gemfile.chop! << "\n\n# Gem for build debian (deb) packages\ngem 'fpm'\n\n" unless gemfile.match /gem ['"]fpm['"]/
      File.open(gemfile_path, 'w') { |f| f.write gemfile }
    end

  end
end
