# Bundler.require(:default)
require 'configureasy'

module Buildable
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
    # Recipe[:vendor_gems]
    Recipe[:create_scripts]
    Recipe[:create_env]
    Recipe[:make_package]
    Recipe[:remove_path]
  end

  def build_app_dir
    File.join(BUILD_ROOT_DIR, 'r7', Buildable.config.project_name)
  end

  def post_install_filename
    File.join(Buildable::BUILD_DIR, 'post_install.sh')
  end

end
