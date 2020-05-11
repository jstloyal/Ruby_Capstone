class Error_check
  attr_reader :error_messages, :file_name, :valid
  
  def initialize(file_name)
    @file_name = file_name
    @error_messages = []
    @valid = true
    begin
      file_data = File.read(file_name).split
    rescue StandardError
      @valid = false
    end
    check_errors(file_data) if @valid
  end

  def check_errors(file_data)
    check_indentation(file_data)
    check_trailing_space(file_data)
    check_double_space(file_data)
    check_double_quotes(file_data)
    check_new_line(file_data)
  end

  def check_indentation(file_data)
    file_data.each do |line|
      
  
      @error_messages << {line_num: , message: 'Wrong indentation space' }
    end
  end

  def check_trailing_space(file_data)
    file_data.each do |line|
      if line[-1] = ''
        @error_messages << {line_num: , message: 'Trailing whitespace detected' }
      else
        false
      end
    end
  end

  def check_double_space(file_data)
    file_data.each do |line|
      line.map do |spaces|
        @error_messages << {line_num: , message: 'Operator = should be surrounded by a single space.' } if spaces = '  '
      else
        false
      end
  
      # @error_messages << {line_num: , message: 'Operator = should be surrounded by a single space.' }
    end
  end

  def check_double_quotes(file_data)
    file_data.each do |line|
      line.map do |x|
        if x = '/"'
          @error_messages << {line_num: , message: 'Prefer single-quoted strings when you don\'t need string interpolation or special symbols' }
        else
          false
        end
      end
  
      # @error_messages << {line_num: , message: 'Prefer single-quoted strings when you don\'t need string interpolation or special symbols' }
    end
  end
  
  def check_new_line(file_data)
    file_data.each do |line|
      
  
      @error_messages << {line_num: , message: 'Extra blank line detected' }
    end
  end  
  
  
end