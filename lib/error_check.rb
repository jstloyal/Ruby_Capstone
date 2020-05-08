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
  
end