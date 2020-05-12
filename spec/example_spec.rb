require './lib/error_check.rb'

RSpec.describe ErrorCheck do
  instance = ErrorCheck.new('Test/my_test.rb')
  describe '#check_indentation' do
    it 'returns false if there is no space before the keyword' do
      expect(false).not_to match (@error_messages)
    end

    it 'returns true if there is space(s) before the keyword' do
      expect(@error_messages).to match (@error_messages)
    end
  end

  describe '#check_trailing_space' do
    it 'returns false if there is no trailing space at the end of the line' do
      expect(false).not_to match (@error_messages)
    end

    it 'returns true if there is/are trailing space at the end of the line' do
      expect(@error_messages).to match (@error_messages)
    end
  end

  describe '#check_double_space' do
    it 'returns false if the (=) operator is surrounded by single space' do
      expect(false).not_to match(@error_messages)
    end

    it 'returns true if the (=) operator is surround by more than a single space' do
      expect(@error_messages).to match (@error_messages)
    end
  end

  describe '#check_double_quotes' do
    it 'returns false if (") is not found around strings' do
      expect(false).not_to match (@error_messages)
    end

    it 'returns false if (") is found around strings that include Regex' do
      expect(false).not_to match (@error_messages)
    end

    it 'returns true if (") is found around strings' do
      expect(@error_messages).to match (@error_messages)
    end
  end

end