class String

  # Underscore text (downcase and replace now-char to '-')
  #  Example:
  #  "some_text".underscore # => "some-text"
  #  "R7.com".underscore # => "r7-com"
  def underscore
    self.strip.downcase.gsub(/\W/, '-')
  end

end