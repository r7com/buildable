module Buildable::FileMaker
  module_function

  def create(filename, content = '')
    if File.exists? filename
      puts "#{filename} exist skipping".colorize(:light_red)
    else
      puts "Creating #{filename}".colorize(:green)
      File.open(filename, 'w') { |file| file.write content }
    end
  end

end