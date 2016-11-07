require 'configureasy'

module Buildable
  require_relative 'core_ext/hash'
  require_relative 'core_ext/string'
  require_relative 'buildable/shell'
  require_relative 'buildable/file_maker'
  require_relative 'buildable/recipe'
  require_relative 'buildable/version'

  include ::Configureasy
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

  def initd_folder
    File.join(BUILD_ROOT_DIR, 'etc/init.d')
  end

  def check_configs
    return if File.exist?('.buildable.yml') && File.exist?('production.env') && File.exist?('Procfile')
    puts "Missing config please run buildable init to create it."
    exit 1
  end

  def files_to_pack
    files_to_ignore = self.config.files_to_ignore + %w{. .. .build .buildable.yml vendor}
    Dir.entries('.') - files_to_ignore
  end

  def foreman_templates
    File.expand_path('../../templates/foreman', __FILE__)
  end

  # Make package name using Organization name (when available) with project name
  def package_name
    [config.organization, config.project_name].compact.collect(&:underscore).join('-')
  end

  def dependencies
    Buildable.config.depends || []
  end

end
