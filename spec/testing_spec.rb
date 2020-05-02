require './lib/modules'

describe LintError do # rubocop:disable Metrics/BlockLength
  describe '#semicolon_error' do
    it 'if gives an error if a semicolon is used to end an expression' do
      test = LintError.new
      file = File.open('sample.rb')
      lines = file.readlines.map(&:chomp)
      expect(test.semicolon_error(lines)).to eql('warning: do not use semicolons to terminate expresssions') # rubocop:disable Layout/LineLength
    end
  end

  describe '#line_length_error' do
    it 'return a warning of a lenghty line' do
      test = LintError.new
      file = File.open('sample.rb')
      lines = file.readlines.map(&:chomp)
      expect(test.line_length_error(lines)).to eql('warning: line is too long')
    end
  end

  describe '#white_space' do
    it 'it return an error if the first character in a line a space' do
      test = LintError.new
      file = File.open('sample.rb')
      lines = file.readlines.map(&:chomp)
      expect(test.white_space(lines)).to eql('warning: first line identation')
    end
  end

  describe '#first_line_blank' do
    it 'returns a warning if the first line in a page is blank' do
      test = LintError.new
      file = File.open('sample.rb')
      lines = file.readlines.map(&:chomp)
      expect(test.first_line_blank(lines)).to eql('warning: unnecessary space at beginning') # rubocop:disable Layout/LineLength
    end
  end

  describe '#wrong_combination' do
    it 'return a warning for adding a string to an integer' do
      test = LintError.new
      a = 'b'
      b = 2
      expect(test.wrong_combination(a, b)).to eql('warning: cannot add string to integer')
    end
  end

  describe '#line_end' do
    it 'return a warning if there are blank lines below the last character' do
      test = LintError.new
      file = File.open('sample.rb')
      lines = file.readlines.map(&:chomp)
      expect(test.line_end(lines)).to eql('warning: trailing blank line')
    end
  end

  describe '#spacing_signs' do
    it 'it returns a warning if there is an extra space at the end of an expression' do # rubocop:disable Layout/LineLength
      test = LintError.new
      file = File.open('sample.rb')
      lines = file.readlines.map(&:chomp)
      expect(test.spacing_signs(lines)).to eql('warning: remove extra space')
    end
  end

  describe '#end_line_space' do
    it 'return a warning if there is no blank line before the last line with characters' do # rubocop:disable Layout/LineLength
      test = LintError.new
      file = File.open('sample.rb')
      lines = file.readlines.map(&:chomp)
      expect(test.end_line_space(lines)).to eql('final newline missing')
    end
  end
end
