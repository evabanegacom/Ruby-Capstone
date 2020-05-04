require './lib/modules'

describe LintError do # rubocop:disable Metrics/BlockLength
  test = LintError.new
  file = File.open('sample.rb')
  lines = file.readlines.map(&:chomp)

  describe '#semicolon_error' do
    it 'if gives an error if a semicolon is used to end an expression' do
      expect(test.semicolon_error(lines)).to eql('warning: do not use semicolons to terminate expressions') # rubocop:disable Layout/LineLength
    end
  end

  describe '#line_length_error' do
    it 'return a warning of a lenghty line' do
      expect(test.line_length_error(lines)).to eql('warning: line is too long')
    end
  end

  describe '#white_space' do
    it 'it return an error if the first character in a line a space' do
      expect(test.white_space(lines)).to eql('warning: first line identation')
    end
  end

  describe '#first_line_blank' do
    it 'returns a warning if the first line in a page is blank' do
      expect(test.first_line_blank(lines)).to eql('warning: unnecessary space at beginning') # rubocop:disable Layout/LineLength
    end
  end

  describe '#missing_string_comment' do
    it 'returns a warning of missing literal string' do
      expect(test.missing_string_comment(lines)).to eql('warning: frozen literal string missing') # rubocop:disable Layout/LineLength
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
      expect(test.line_end(lines)).to eql('warning: trailing blank line')
    end
  end

  describe '#spacing_signs' do
    it 'it returns a warning if there is an extra space at the end of an expression' do # rubocop:disable Layout/LineLength
      expect(test.spacing_signs(lines)).to eql('warning: remove extra space')
    end
  end

  describe '#end_line_space' do
    it 'return a warning if there is no blank line after the last line with characters' do # rubocop:disable Layout/LineLength
      expect(test.end_line_space(lines)).to eql('final newline missing')
    end
  end
end
