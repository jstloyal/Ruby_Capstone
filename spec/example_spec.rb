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

end