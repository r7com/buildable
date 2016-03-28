module Buildable::Recipe

  recipe :create_path do
    puts "* Preparing structure to build"
    Buildable::Recipe[:remove_path] if Dir.exist? Buildable::BUILD_DIR
    Buildable::Recipe[:clean_pkg] if Dir.exist? Buildable::PACKAGE_DIR
    FileUtils.mkdir_p(Buildable.build_app_dir)
    FileUtils.mkdir_p('./pkg')
  end

  recipe :copy_source do
    Buildable.files_to_pack.each do |file|
      puts "\tCopying #{file}"
      FileUtils.cp_r file, File.join(Buildable.build_app_dir, file)
    end
  end

  recipe :vendor_gems do
    puts '* Fetching gems'
    Bundler.with_clean_env do
      Dir.chdir Buildable.build_app_dir do
        Buildable::Shell.do 'bundle install --deployment --without development test'
        raise "Can't fetching gems" unless Buildable::Shell.success?
      end
    end
  end

  recipe :make_init_script do
    puts "* Generating init scripts"
    # Buildable::Shell.do "foreman export upstart #{Buildable.upstart_folder} -u #{Buildable.config.app_user} -e production.env -a #{Buildable.config.project_name.downcase}"
    params = {
      '--user' => Buildable.config.app_user,
      '--env' => 'production.env',
      '--app' => Buildable.config.project_name.downcase,
      '--log' => '/tmp',
      '--template' => Buildable.foreman_templates,
      '-f' => 'Procfile',
      '-d' => Buildable.config.root_dir
    }
    Buildable::Shell.do "foreman export initscript #{Buildable.initd_folder}", params

    raise "Can't generate init scripts" unless Buildable::Shell.success?
    initscript = File.join Buildable.initd_folder, Buildable.config.project_name
    FileUtils.chmod "+x", initscript
  end

  recipe :make_package do
    puts "* Creating package"
    version = Buildable::Shell.do_quiet %Q{git describe --abbrev=0 --match="[0-9]*\.[0-9]*\.[0-9]*"}
    raise "Can't define build version, please check git describe" unless Buildable::Shell.success?
    # result = Buildable::Shell.do_quiet "bundle exec fpm -s dir -t deb --name r7-#{Buildable.config.project_name.downcase} --version #{version} --architecture all --maintainer R7 --force --package ./pkg --prefix / --description #{Buildable.config.description.inspect} #{Buildable.add_pre_install} #{Buildable.add_post_install} -C '#{Buildable::BUILD_ROOT_DIR}' ./etc ./r7"
    params = {
      '-s' => 'dir',
      '-t' => 'deb',
      '--name' => "r7-#{Buildable.config.project_name.downcase}",
      '--version' => version,
      '--architecture' => 'all',
      '--package' => './pkg',
      '--prefix' => '/',
      '--description' => Buildable.config.description.inspect,
      '--force' => nil,
      '-C' => "#{Buildable::BUILD_ROOT_DIR} ./etc #{Buildable.config.root_dir}"
    }

    result = Buildable::Shell.do_quiet 'bundle exec fpm', params
    raise "Can't create package, error:\n#{result}" unless Buildable::Shell.success?
    package_name = result.match(/:path=>"\.\/pkg\/([^"]*)/)[1]
    puts "\tPackage created #{package_name}"
  end

  recipe :remove_path do
    puts "* Clean up build folder"
    FileUtils.rm_rf Buildable::BUILD_DIR
  end

  recipe :clean_pkg do
    puts "* Clean up pkg folder"
    FileUtils.rm_rf Buildable::PACKAGE_DIR
  end

end
