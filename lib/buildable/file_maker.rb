require 'erb'

module Buildable::FileMaker
  class << self

    # create plain_text file with content
    #
    # plain_text('test.txt') { |content| content << "hi" }
    # # => create test.txt file with "hi" inside
    def plain_text(filename, options = {})
      # check if exist and be overwrite
      content = yield('')
      File.open(filename, 'w') { |file| file.write content }
    end

    def template(name, location = './', options = {})
      destination = File.join(location, name)
      # check if exist and can overwrite

      template = load_template(name)
      raise "Template #{name} not found" unless template

      builder = ERB.new(template)
      File.open(destination, 'w') { |f| f.write builder.result }
    end

    private

    def load_template(name)
      filename = File.expand_path("../../../templates/#{name}.erb", __FILE__)
      File.read(filename) if File.exist? filename
    end
  end
end
