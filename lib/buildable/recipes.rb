require 'erb'
require 'yaml'
require 'fileutils'

module Buildable::Recipes
  class << self
    @@recipes = {}

    def [](name)
      @@recipes[name].call if @@recipes.has_key?(name)
    end

    def recipe(name, &block)
      @@recipes[name] = block
    end
  end

  recipe :init do
    puts "Creating Procfile"
    File.open('Procfile', 'w')       { |f| f.write "production: bundle exec unicorn -c config/unicorn.rb\ndevelopment: bundle exec rackup -p 3000\n" }
    puts "Creating .buildable.yml"
    File.open('.buildable.yml', 'w') { |f| f.write({'project_name' => 'app name', 'description' => 'Most awesome project in the world', 'exclude_dirs' => %w{. .. config spec features test .git .gitignore .buildable.yml .build pkg log}}.to_yaml) }
    puts "Please edit .buildable.yml to setup application"
  end

  recipe :create_path do
    puts "Preparing structure to build"
    Buildable::Recipes[:remove_path] if Dir.exist? Buildable::BUILD_DIR
    FileUtils.mkdir_p(Buildable.build_app_dir)
    FileUtils.mkdir_p('./pkg')
  end

  recipe :copy_source do
    files = Dir.entries('.') - Buildable.config.exclude_dirs
    files.each do |file|
      puts "\tCopying #{file}"
      FileUtils.cp_r file, File.join(Buildable.build_app_dir, file)
    end
  end

  recipe :create_scripts do
    puts "Creating post_install script"
    template_file = File.expand_path('../../../templates/post_install.sh.erb', __FILE__)
    content = ERB.new(File.read template_file)
    File.open(Buildable.post_install_filename, 'w') { |file| file.write content.result }
    FileUtils.chmod 0755, Buildable.post_install_filename
  end

  recipe :make_package do
    version = %x{git describe --abbrev=0 --match="[0-9]*\.[0-9]*\.[0-9]*"}.chomp
    raise "Can't define build version, please check git describe" unless version

    puts "Creating package version #{version}"
    stdout = %x{bundle exec fpm -s dir -t deb --name #{Buildable.config.project_name} --version #{version} --architecture all --maintainer R7 --force --package ./pkg --prefix / --description #{Buildable.config.description.inspect} --post-install #{Buildable.post_install_filename} -C "#{Buildable::BUILD_ROOT_DIR}" ./r7 2>&1}
    raise "Can't create package, error:\n#{stdout}" unless $?.success?
  end

  recipe :remove_path do
    puts "Cleaning"
    FileUtils.rm_rf Buildable::BUILD_DIR
  end

end