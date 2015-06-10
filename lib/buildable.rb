require 'bundler'
Bundler.require(:default)
load File.expand_path('../../lib/tasks/buildable.task', __FILE__) if defined?(Rake)

module Buildable
  require_relative 'buildable/shell'
  require_relative 'buildable/file_maker'
  require_relative 'buildable/recipe'

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
    Recipe[:create_path]
    Recipe[:copy_source]
    Recipe[:vendor_gems]
    Recipe[:make_init_script]
    Recipe[:make_package]
    Recipe[:remove_path]
  end

  def build_app_dir
    File.join(BUILD_ROOT_DIR, 'r7', Buildable.config.project_name)
  end

  def upstart_folder
    File.join(BUILD_ROOT_DIR, 'etc/init')
  end

end
