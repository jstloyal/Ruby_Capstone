class ErrorCheck
  attr_reader :error_messages, :file_name, :valid

  def initialize(file_name)
    @file_name = file_name
    @error_messages = []
    @valid = true
    begin
      file_data = []
      File.open(file_name).each { |line| file_data << line }
    rescue StandardError
      @valid = false
    end
    check_errors(file_data) if @valid
  end

  def check_errors(file_data)
    check_new_empty_line(file_data)
    check_trailing_space(file_data)
    check_double_space(file_data)
    check_indentation(file_data)
    check_double_quotes(file_data)
  end

  def check_trailing_space(file_data)
    file_data.each_with_index do |line, i|
      @error_messages << { line_num: i + 1, message: 'Trailing whitespace detected' } if line[-2] == ' '
    end
  end

  def check_double_space(file_data)
    file_data.each_with_index do |line, i|
      if line.strip.include? '=  '
        @error_messages << { line_num: i + 1, message: 'Operator = should be surrounded by a single space' }
      elsif line.strip.include? '  ='
        @error_messages << { line_num: i + 1, message: 'Operator = should be surrounded by a single space' }
      end
    end
  end

  def check_double_quotes(file_data)
    file_data.each_with_index do |line, i|
      next unless line.include? '"'

      unless quotes_contain_variable(line)
        @error_messages << { line_num: i + 1, message: 'Prefer single-quoted strings when you don\'t need string interpolation or special symbols' }
      end
    end
  end

  def check_indentation(file_data)
    key_words = ['class']
    file_data.each_with_index do |line, i|
      temp_string = line.strip
      key_words.each do |value|
        @error_messages << { line_num: i + 1, message: 'Wrong indentation space' } if temp_string[0...value.size] == value && line[0] == ' '
      end
    end
  end

  def check_new_empty_line(file_data)
    file_data.each_with_index do |line, i|
      next unless line.strip.size.zero?

      @error_messages << { line_num: i + 1, message: 'Extra blank line detected' } if file_data[i + 1].strip.size.zero?
    end
  end

  private

  def quotes_contain_variable(line)
    quote_position = line.index('"')
    return false if quote_position.nil?

    rest_of_line = line[quote_position + 1..-1]
    second_quote_position = rest_of_line.index('"')
    quotes_content = line[quote_position + 1..second_quote_position]
    quotes_content.include? '#{'
  end
end
