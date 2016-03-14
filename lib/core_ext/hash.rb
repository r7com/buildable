class Hash

  # Generate params string based on hash content
  #   {'--param': 'value', '-a': nil, '--config': 'path/to/config'}.to_params
  #   # "--param value -a --config path/to/config"
  def to_params
    return '' if self.empty?
    self.flatten.compact.join(' ')
  end

end