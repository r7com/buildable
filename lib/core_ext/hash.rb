class Hash

  # Generate params string based on hash content
  #   {'--param': 'value', '-a': nil, '--config': 'path/to/config'}.to_params
  #   # "--param value -a --config path/to/config"
  # Array values duplicate the key
  #   {'--depends': ['a','b','c'], '--param': 'value'}.to_params
  #   # "--depends a --depends b --depends c --param value"
  def to_params
    return '' if self.empty?
    [].tap do |tokens|
      self.each do |key, value|
        if value.is_a? Array
          value.each do |item|
            tokens << key
            tokens << item
          end
        else
          tokens << key
          tokens << value
        end
      end
    end.join(' ')
  end

end
