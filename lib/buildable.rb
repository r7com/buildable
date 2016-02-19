require 'bundler'
Bundler.require(:default)

module Buildable
  require_relative 'buildable/shell'
  require_relative 'buildable/file_maker'
  require_relative 'buildable/recipe'
  require_relative 'buildable/rake_helper'

  include Configureasy
  load_config '.buildable', as: 'config', path: '.'

  BUILD_DIR      = './.build'
  BUILD_ROOT_DIR = './.build/root'
  PACKAGE_DIR    = './pkg'

  module_function

  def init
    Recipe[:init]
  end

  def build
    STDOUT.sync = true
    check_configs
    Recipe[:create_path]
    Recipe[:copy_source]
    Recipe[:vendor_gems]
    Recipe[:make_init_script]
    Recipe[:make_package]
    Recipe[:remove_path]
  end

  def build_app_dir
    File.join(BUILD_ROOT_DIR, Buildable.config.root_dir)
  end

  def upstart_folder
    File.join(BUILD_ROOT_DIR, 'etc/init')
  end

  def check_configs
    return if File.exist?('.buildable.yml') && File.exist?('production.env') && File.exist?('Procfile')
    puts "Missing config please run buildable init to create it."
    exit 1
  end

  def files_to_ignore
    self.config.files_to_ignore.tap do |files|
      files << %w{. .. .build .buildable.yml}
    end
  end

end
