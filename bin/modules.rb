class LintError
  def semicolon_error(lines)
    lines.each_with_index do |line, index|
      return 'warning: on line ' + (index + 1).to_s + ' do not use semicolons to terminate expressions' if line[-1] == ';' # rubocop:disable Layout/LineLength
      return 'warning: empty trailing white space' if line[-1] == ' '
    end
  end

  def line_length_error(lines)
    lines.each_with_index do |line, index|
      return 'warning: line  ' + (index + 1).to_s + '  is too long' if line.size >= 80
    end
  end

  def white_space(lines1)
    lines1.each_with_index do |_line, index|
      return "warning: on line #{lines1.size}  first line identation" if lines1[0][0] == ' '
    end
  end

  def first_line_blank(lines)
    lines.each_with_index do |_line, index|
      return 'warning: on line ' + (index + 1).to_s + ' unnecessary space at beginning' if lines[0].length.zero?
    end
  end

  def missing_string_comment(lines)
    lines.each_with_index do |_line, index|
      return 'warning: on line ' + (index + 1).to_s + ' frozen literal string missing' if lines[0].length.zero?
    end
  end

  def line_end(lines)
    return 'warning: on last line trailing blank lines' if lines[-2].size.zero?
  end

  def spacing_signs(lines)
    lines.each_with_index do |line, index|
      return 'warning: on line ' + (index + 1).to_s + ' remove extra space at the end' if line[-1] == ' '
    end
  end

  def end_line_space(lines)
    return "after line #{lines.size} final newline missing" if lines.last.length.positive?
  end

  def wrong_combination(item1, item2)
    return 'warning: cannot add string to integer' if item1.is_a?(String) && item2.is_a?(Integer) || if item2.is_a?(String) && item1.is_a?(Integer) # rubocop:disable Layout/LineLength
                                                                                end

    item1 + item2
  end

  def run_linter(lines)
    errors = []
    error = line_length_error(lines)
    errors.append(error) if error
    error = semicolon_error(lines)
    errors.append(error) if error
    error = end_line_space(lines)
    errors.append(error) if error
    error = spacing_signs(lines)
    errors.append(error) if error
    error = missing_string_comment(lines)
    errors.append(error) if error
    error = line_end(lines)
    errors.append(error) if error
    error = first_line_blank(lines)
    errors.append(error) if error
    errors
  end

  def anodafunc(lines1)
    errors = []
    error = white_space(lines1)
    errors.append(error) if error
    errors
  end
end

test = LintError.new
file = File.open('sample.rb')
lines = file.readlines.map(&:chomp)
results = test.run_linter(lines)
print 'no error' if results.length.zero?


files = File.open('file_path.rb')
lines1 = files.readlines.map(&:chomp)
results1 = test.anodafunc(lines1)

puts results1
puts results

#puts lines.size
