require './bin/main'

describe LintError do
  test = LintError.new
  file = File.open('lib/sample.rb')
  lines = file.readlines.map(&:chomp)

  files = File.open('lib/file_path.rb')
  lines1 = files.readlines.map(&:chomp)

  describe '#semicolon_error' do
    it 'if gives an error if a semicolon is used to end an expression' do
      expect(test.semicolon_error(lines)).to eql(['warning: on line 2 do not use semicolons to terminate expressions'])
    end
  end

  describe '#line_length_error' do
    it 'return a warning of a lenghty line' do
      expect(test.line_length_error(lines)).to eql(['warning: line  4  is too long'])
    end
  end

  describe '#white_space' do
    it 'it return an error if the first character in the first  line is a space' do
      expect(test.white_space(lines1)).to eql(['warning: on line 1 first line identation of file_path'])
    end
  end

  describe '#first_line_blank' do
    it 'returns a warning if the first line in a page is blank' do
      expect(test.first_line_blank(lines)).to eql(['warning: on line 1 empty space at beginning'])
    end
  end

  describe '#missing_string_comment' do
    it 'returns a warning of missing literal string' do
      expect(test.missing_string_comment(lines)).to eql(['warning: on line 1 frozen literal string missing'])
    end
  end

  describe '#line_end' do
    it 'return a warning if there are blank lines below the last character' do
      expect(test.line_end(lines1)).to eql(['warning: on line 4 trailing blank lines'])
    end
  end

  describe '#spacing_signs' do
    it 'it returns a warning if there is an extra space at the end of an expression' do 
      expect(test.spacing_signs(lines)).to eql(['warning: on line 5 remove extra space at the end'])
    end
  end

  describe '#end_line_space' do
    it 'return a warning if there is no blank line after the last line with characters' do 
      expect(test.end_line_space(lines)).to eql(['after line 5 final newline missing'])
    end
  end
end
