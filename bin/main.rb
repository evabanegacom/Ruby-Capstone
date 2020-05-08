class LintError
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
      warning.append('warning: line  ' + (index + 1).to_s + '  is too long') if line.size >= 80
    end
    warning
  end

  def white_space(lines1)
    warning = []
    warning.append('warning: on line 1 first line identation of file_path') if lines1[0][0] == ' '
    warning
  end

  def first_line_blank(lines)
    warning = []
    warning.append('warning: on line 1 empty space at beginning') if lines[0].length.zero?
    warning
  end

  def missing_string_comment(lines)
    warning = []
    warning.append('warning: on line 1 frozen literal string missing') if lines[0].length.zero?
    warning
  end

  def line_end(lines1)
    warning = []
    warning.append("warning: on line #{lines1.size + 1} trailing blank lines") if lines1[-2].size.zero?
    warning
  end

  def spacing_signs(lines)
    warning = []
    lines.each_with_index do |line, index|
      warning.append('warning: on line ' + (index + 1).to_s + ' remove extra space at the end') if line[-1] == ' '
    end
    warning
  end

  def end_line_space(lines)
    warning = []
    warning.append("after line #{lines.size} final newline missing") if lines.last.length.positive?
    warning
  end

  def run_linter(lines) # rubocop:disable Metrics/CyclomaticComplexity
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
file = File.open('test-files/sample.rb')
lines = file.readlines.map(&:chomp)
results = test.run_linter(lines)
print 'no error' if results.length.zero?

files = File.open('test-files/file_path.rb')
lines1 = files.readlines.map(&:chomp)
results1 = test.anodafunc(lines1)

puts results1
puts results
