module Buildable::FileMaker
  module_function

  def create(filename, content = '')
    if File.exists? filename
      puts "  skipping #{filename} file exists".colorize(:light_red)
    else
      puts "  creating #{filename}".colorize(:green)
      File.open(filename, 'w') { |file| file.write content }
    end
  end

  def clean_path(path)
    FileUtils.rm_rf path if Dir.exists? path
    Dir.mkdir path
  end
end