class LintError # rubocop:disable Style/FrozenStringLiteralComment, Style/Documentation
  def semicolon_error(lines)
    lines.each do |line|
      return 'warning: do not use semicolons to terminate expressions' if line[-1].strip == ';' # rubocop:disable Layout/LineLength
      return 'warning: empty trailing white space' if line[-1] == ' '
    end
  end

  def line_length_error(lines)
    lines.each do |line|
      return 'warning: line is too long' if line.size >= 80
    end
  end

  def white_space(lines)
    return 'warning: first line identation' if lines[0][0] == ' '
  end

  def first_line_blank(lines)
    return 'warning: unnecessary space at beginning' if lines[0].length.zero?
  end

  def missing_string_comment(lines)
    return 'warning: frozen literal string missing' if lines[0].length.zero?
  end

  def line_end(lines)
    return 'warning: trailing blank line' if lines[-1] == ''
  end

  def spacing_signs(lines)
    lines.each do |line|
      return 'warning: remove extra space' if line[-1] == ' '
    end
  end

  def end_line_space(lines)
    return 'final newline missing' if lines[-1].length.positive?
  end

  def wrong_combination(item1, item2)
    return 'warning: cannot add string to integer' if item1.is_a?(String) && item2.is_a?(Integer) || if item2.is_a?(String) && item1.is_a?(Integer) # rubocop:disable Layout/LineLength
                                                                                end

    item1 + item2
  end

  def run_linter(lines)
    errors = []
    error = white_space(lines)
    errors.append(error) if error
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
end

test = LintError.new
file = File.open('sample.rb')
lines = file.readlines.map(&:chomp)
results = test.run_linter(lines)
print 'no error' if results.length.zero?
puts results
