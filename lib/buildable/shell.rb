require 'pty'

module Buildable::Shell
  extend self

  def success?
    $? && $?.success?
  end

  def do(command)
    PTY.spawn("#{command} 2>&1") do |r,w,pid|
      r.each { |line| puts "\t#{line}" } rescue nil # prevents error when process ending
      Process.wait(pid)
    end
  rescue PTY::ChildExited
    true
  end

  def do_quiet(command)
    %x{#{command} 2>&1}.chomp
  end

end