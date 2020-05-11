class TheTest
  def initialize(*args)
    @first_name = args[0]
    @last_name = args[1]
  end

  def show_info
    puts @first_name + ' ' + @last_name
  end
end