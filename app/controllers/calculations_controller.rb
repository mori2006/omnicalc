class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split_into_array = @text.split

    text_character_count_with_spaces = @text.length

    text_character_count_without_spaces = @text.gsub(" ", "")

    downcase_special_word = @special_word.downcase

    downcase_text_split_into_array = @text.downcase.gsub(/[^a-z0-9\s]/i, '').split


    @word_count = text_split_into_array.length

    @character_count_with_spaces = text_character_count_with_spaces

    @character_count_without_spaces = text_character_count_without_spaces.length

    @occurrences = downcase_text_split_into_array.count(downcase_special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    if
      @apr!=0
      calulated_monthly_payment = (@apr/100/12*@principal*(1+@apr/100/12)**(@years*12))/((1+@apr/100/12)**(@years*12)-1)
    else
      calulated_monthly_payment = "NaN"
    end

    @monthly_payment = calulated_monthly_payment

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================
    seconds_between = @ending -@starting


    @seconds = seconds_between
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    sorted_numbers = @numbers.sort

    num_count = @numbers.count

    if

      num_count.odd?
      median = sorted_numbers[num_count/2]
    else
      median = (sorted_numbers[num_count/2] + sorted_numbers[num_count/2-1])/2

    end

    sum_of_numbers = sorted_numbers.sum

    mean_of_numbers = sum_of_numbers/num_count

    sq_diff = []

    sorted_numbers.each do |i|
      sq_diff.push((i - mean_of_numbers)**2)
    end

    variance_of_numbers = (sq_diff.sum)/(num_count)

    num_frequency = []

    sorted_numbers.each do |i|
      count_of_i = sorted_numbers.count(i)
      num_frequency.push(count_of_i)
    end

    position_of_mode = num_frequency.index(num_frequency.max)

    mode = sorted_numbers[position_of_mode]

    

    @sorted_numbers = sorted_numbers

    @count = num_count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @median = median

    @sum = sum_of_numbers

    @mean = mean_of_numbers

    @variance = variance_of_numbers

    @standard_deviation = (@variance)**(0.5)

    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
