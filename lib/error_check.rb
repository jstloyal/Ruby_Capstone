class Error_check
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
    check_indentation(file_data)
    check_trailing_space(file_data)
    check_double_space(file_data)
    check_double_quotes(file_data)
  end

  def check_indentation(file_data)
    key_words = ['class']
    file_data.each_with_index do |line, i|
      temp_string = line.strip
      key_words.each do |value|
        if temp_string[0...value.size] == value
          if line[0] == ' '
            @error_messages << {line_num: i + 1, message: 'Wrong indentation space' }
          end
        end
      end
    end
  end

  def check_trailing_space(file_data)
    file_data.each_with_index do |line, i|
      if line[-2] == ' '
        @error_messages << {line_num: i + 1, message: 'Trailing whitespace detected' }
      end
    end
  end

  def check_double_space(file_data)
    file_data.each_with_index do |line, i| 
      @error_messages << {line_num: i + 1, message: 'Operator = should be surrounded by a single space.' } if line.strip.include? '=  '
      @error_messages << {line_num: i + 1, message: 'Operator = should be surrounded by a single space.' } if line.strip.include? '  ='
    end
  end

  def check_double_quotes(file_data)
    file_data.each_with_index do |line, i|
      if line.include? '"'
        unless quotes_contain_variable(line)
          @error_messages << {line_num: i + 1, message: 'Prefer single-quoted strings when you don\'t need string interpolation or special symbols' }
        end
      end
    end
  end
  
  def check_new_empty_line(file_data)
    file_data.each_with_index do |line, i|
      if line.strip.size == 0
        if file_data[i + 1].strip.size == 0
          @error_messages << {line_num: i + 1, message: 'Extra blank line detected' }
        end
      end
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
