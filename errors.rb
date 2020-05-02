  file = File.open('sample.rb')
  lines = file.readlines.map(&:chomp)
  #print lines

  def semicolon_error(lines)
    lines.each do |line|
      puts 'Warning: do not use semicolons to terminate expresssions' if line[-1] == ';'
      puts 'warning: empty trailing white space' if line[-1] == ' '
    end
  end

  def line_length_error(lines)
    lines.each do |line|
      puts 'warning: line is too long' if line.size >= 80
    end
  end

  def white_space(lines)
    puts 'warning: inconsistent identation' if lines[0][0] == ' '
  end

  def first_line_blank(lines)
    puts 'warning: unnecessary space at beginning' if lines[0].length.zero?
  end

  def line_end(lines)
    puts 'trailing blank line' if lines[-1] == ''
  end

  def spacing_signs(lines)
    lines.each do |line|
      puts 'warning: hello remove extra space' if line[-1] == ' '
    end
  end

  def end_line_space(lines)
    puts 'final newline missing' if lines[-1].length.positive?
  end

  def begin_func(item1, item2)
    puts 'warning: cannot add string to integer' if item1.is_a?(String) && item2.is_a?(Integer)|| if item2.is_a?(String) && item1.is_a?(Integer)
    end

    item1 + item2
  end

  a = 'a'
  b = 2
spacing_signs(lines)
semicolon_error(lines)
line_length_error(lines)
#begin_func(a, b)
end_line_space(lines)
line_end(lines)
first_line_blank(lines)
white_space(lines)
