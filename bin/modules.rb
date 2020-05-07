class LintError # rubocop:disable Style/Documentation, FrozenStringLiteralComment
  def semicolon_error(lines)
    warning = []
    warnings = []
    lines.each_with_index do |line, index|
      if line[-1] == ';'
        warning.append('warning: on line ' + (index + 1).to_s + ' do not use semicolons to terminate expressions')
        warnings.append('warning: empty trailing white space')
      end
    end
    warning
  end

  def line_length_error(lines)
    warning = []
    lines.each_with_index do |line, index|
      if line.size >= 80
        warning.append('warning: line  ' + (index + 1).to_s + '  is too long')
      end
    end
    warning
  end

  def white_space(lines1)
    warning = []
      if lines1[0][0] == ' '
        warning << 'warning: on line 1 first line identation of file_path'
      end
    warning
  end

  def first_line_blank(lines)
    warning = []
      if lines[0].length.zero? 
        warning << 'warning: on line 1 empty space at beginning'
      end
    warning
  end

  def missing_string_comment(lines)
    warning = []
    if lines[0].length.zero? 
      warning << 'warning: on line 1 frozen literal string missing'
    end
    warning
  end

  def line_end(lines1)
    warning = []
    if lines1[-2].size.zero?
      warning.append("warning: on line #{lines1.size + 1} trailing blank lines")
    end
    warning
  end

  def spacing_signs(lines)
    warning = []
    lines.each_with_index do |line, index|
      if line[-1] == ' '
      warning << 'warning: on line ' + (index + 1).to_s + ' remove extra space at the end'
      end
    end
    warning
  end

  def end_line_space(lines)
    warning = []
    if lines.last.length.positive?
      warning << "after line #{lines.size} final newline missing"
    end
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
    error = first_line_blank(lines)
    errors.append(error) if error
    errors
  end

  def anodafunc(lines1)
    errors = []
    error = white_space(lines1)
    errors.append(error) if error
    error = line_end(lines1)
    errors.append(error) if error
    errors
  end
end

test = LintError.new
file = File.open('lib/sample.rb')
lines = file.readlines.map(&:chomp)
results = test.run_linter(lines)
print 'no error' if results.length.zero?

files = File.open('lib/file_path.rb')
lines1 = files.readlines.map(&:chomp)
results1 = test.anodafunc(lines1)

puts results1
puts results
