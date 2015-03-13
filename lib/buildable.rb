# Bundler.require(:default)
require 'configureasy'

require_relative 'buildable/recipes'

module Buildable
  include Configureasy
  load_config '.buildable', as: 'config', path: '.'

  BUILD_DIR      = './.build'
  BUILD_ROOT_DIR = './.build/root'
  PACKAGE_DIR    = './pkg'

  module_function

  def init
    Recipes[:init]
  end

  def build
    Recipes[:create_path]
    Recipes[:copy_source]
    Recipes[:create_scripts]
    Recipes[:make_package]
    Recipes[:remove_path]
  end

  def build_app_dir
    File.join(BUILD_ROOT_DIR, 'r7', Buildable.config.project_name)
  end

  def post_install_filename
    File.join(Buildable::BUILD_DIR, 'post_install.sh')
  end

end
