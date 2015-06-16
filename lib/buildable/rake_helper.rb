require 'rake'

module Buildable::RakeHelper
  include Rake::DSL if defined? Rake::DSL
  extend self

  def install_tasks
    namespace :buildable do
      set_init_task
      set_build_task
    end
  end

  private

  def set_init_task
    desc "Create package buildable structure"
    task :init do
      Buildable.init
    end
  end

  def set_build_task
    desc "Make debian (deb) package"
    task :build do
      Buildable.build
    end
  end
end
