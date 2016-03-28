require 'pty'

module Buildable::Shell
  extend self

  def success?
    !!($? && $?.success?)
  end

  def do(command, params = {})
    PTY.spawn(command_line(command, params)) do |r,w,pid|
      r.each { |line| puts "\t#{line}" } rescue nil # prevents error when process ending
      Process.wait(pid)
    end
  rescue PTY::ChildExited
    true
  end

  def do_quiet(command, params = {})
    %x{#{command_line(command, params)}}.chomp
  end

  private

  def command_line(command, params)
    "#{command} #{params.to_params} 2>&1"
  end

end