require './bin/modules'

describe LintError do # rubocop:disable Metrics/BlockLength
  test = LintError.new
  file = File.open('lib/sample.rb')
  lines = file.readlines.map(&:chomp)

  files = File.open('lib/file_path.rb')
  lines1 = files.readlines.map(&:chomp)

  describe '#semicolon_error' do
    it 'if gives an error if a semicolon is used to end an expression' do
      expect(test.semicolon_error(lines)).to eql('warning: on line 2 do not use semicolons to terminate expressions') # rubocop:disable Layout/LineLength
    end
  end

  describe '#line_length_error' do
    it 'return a warning of a lenghty line' do
      expect(test.line_length_error(lines)).to eql('warning: line  4  is too long') # rubocop:disable Layout/LineLength
    end
  end

  describe '#white_space' do
    it 'it return an error if the first character in the first  line is a space' do # rubocop:disable Layout/LineLength
      expect(test.white_space(lines1)).to eql('warning: on line 1 first line identation of file_path') # rubocop:disable Layout/LineLength
    end
  end

  describe '#first_line_blank' do
    it 'returns a warning if the first line in a page is blank' do
      expect(test.first_line_blank(lines)).to eql('warning: on line 1 unnecessary space at beginning') # rubocop:disable Layout/LineLength
    end
  end

  describe '#missing_string_comment' do
    it 'returns a warning of missing literal string' do
      expect(test.missing_string_comment(lines)).to eql('warning: on line 1 frozen literal string missing') # rubocop:disable Layout/LineLength
    end
  end

  describe '#wrong_combination' do
    it 'return a warning for adding a string to an integer' do
      test = LintError.new
      a = 'b'
      b = 2
      expect(test.wrong_combination(a, b)).to eql('warning: cannot add string to integer') # rubocop:disable Layout/LineLength
    end
  end

  describe '#line_end' do
    it 'return a warning if there are blank lines below the last character' do
      expect(test.line_end(lines1)).to eql('warning: on line 4 trailing blank lines') # rubocop:disable Layout/LineLength
    end
  end

  describe '#spacing_signs' do
    it 'it returns a warning if there is an extra space at the end of an expression' do # rubocop:disable Layout/LineLength
      expect(test.spacing_signs(lines)).to eql('warning: on line 5 remove extra space at the end') # rubocop:disable Layout/LineLength
    end
  end

  describe '#end_line_space' do
    it 'return a warning if there is no blank line after the last line with characters' do # rubocop:disable Layout/LineLength
      expect(test.end_line_space(lines)).to eql('after line 5 final newline missing') # rubocop:disable Layout/LineLength
    end
  end
end
