require 'pry'
require 'colorize'

@main = [
  { meal: 'Cheeseburger', cost: 4.00, calories: '(1000 cals)' },
  { meal: 'Hotdog', cost: 3.00, calories: '(500 cals)' },
  { meal: 'Chicken Nuggets', cost: 3.50, calories: '(600 cals)' }
]

@sides = [
  { side: 'French Fries', cost: 1.50, calories: '(300 cals)' },
  { side: 'English Chips', cost: 2.00, calories: '(350 cals)' },
  { side: 'Onion Rings', cost: 2.50, calories: '(400 cals)' },
  { side: 'Green Salad', cost: 1.50, calories: '(200 cals)' },
  { side: 'Mixed Fruit', cost: 1.00, calories: '(100 cals)' }
]

@desserts = [
  { dessert: 'Cheesecake', cost: 3.00, calories: '(550 cals)' },
  { dessert: 'Chocolate Molten Cake', cost: 2.50, calories: '(750 cals)' },
  { dessert: 'Eclair', cost: 1.00, calories: '(200 cals)' },
  { dessert: 'Chocolate Ice Cream', cost: 0.75, calories: '(300 cals)' }
]

def welcome
  puts "\n-*- WELCOME TO THE RUBY CAFE -*-".colorize(:color => :green)
  wallet_start
  main_menu
end

def wallet_start
  puts "\nHow much do you want to spend today?".colorize(:color => :yellow)
  @wallet_amount = user_input.to_f
  if @wallet_amount < 4.75
    puts "Sorry, you can't afford eating here. Come back another time!".colorize(:color => :red)
    exit
  else
    puts number_to_currency(@wallet_amount)
    puts "Sweet! You can buy a nice meal with #{number_to_currency@wallet_amount}.".colorize(:color => :light_blue)
  end
end

def number_to_currency(amount)
  "$#{sprintf("%.2f", amount.to_s)}"
end

def main_menu
  puts "\nDINNER MENU".colorize(:color => :green)
  @main.each_index{
    |i| puts "#{i + 1 }. #{@main[i][:meal]} #{number_to_currency@main[i][:cost]} #{@main[i][:calories]}"
  }
  puts "\nWhat would you like to order? (1-3)".colorize(:color => :yellow)
  main_choice = user_input.to_i - 1
  if main_choice > 2 || main_choice == -1
    puts "Sorry, invalid option. Please try again.".colorize(:color => :red)
    main_menu
  else
    @main_arr = @main[main_choice]
    puts "Cool! #{@main_arr[:meal]} coming right up! What sides would you like? You get two!".colorize(:color => :light_blue)
    side_menu
  end
end

def side_menu
  puts "\nSIDE MENU".colorize(:color => :green)
  @sides.each_index{
    |i| puts "#{i + 1}. #{@sides[i][:side]} #{number_to_currency@sides[i][:cost]} #{@sides[i][:calories]}"
  }
  puts "\nWhat is your first side going to be? (1-5)".colorize(:color => :yellow)
  side_choice = user_input.to_i - 1
  if side_choice > 4 || side_choice == -1
    puts "Sorry, invalid option. Please try again.".colorize(:color => :red)
    side_menu
  else
    @side_arr = @sides[side_choice]
    puts "Alright, #{@side_arr[:side]}".colorize(:color => :light_blue)
    second_side_dish
  end
end

def second_side_dish
  puts "\nWhat is your second side going to be?".colorize(:color => :yellow)
  second_side = user_input.to_i - 1
  if second_side > 4 || second_side == -1
    puts "Sorry, invalid option. Please try again.".colorize(:color => :red)
    second_side_dish
  else
    @side2_arr = @sides[second_side]
    puts "Nice! #{@side_arr[:side]} and #{@side2_arr[:side]} on their way!".colorize(:color => :light_blue)
    dessert_menu
  end
end

def dessert_menu
  puts "\nDESSERT MENU".colorize(:color => :green)
  @desserts.each_index {
    |i| puts "#{i + 1}. #{@desserts[i][:dessert]} #{number_to_currency@desserts[i][:cost]} #{@desserts[i][:calories]}"
  }
  puts "\nWhat dessert would you like to have?".colorize(:color => :yellow)
  dessert_choice = user_input.to_i - 1
  if dessert_choice > 3 || dessert_choice == -1
    puts "Sorry, invalid option. Please try again.".colorize(:color => :red)
    dessert_menu
  else
    @dessert_arr = @desserts[dessert_choice]
    puts "Yum! #{@dessert_arr[:dessert]} it is!".colorize(:color => :light_blue)
    total_value
  end
end

def total_value
  puts "\nYour grand total for the #{@main_arr[:meal]}, #{@side_arr[:side]}, #{@side2_arr[:side]}, and #{@dessert_arr[:dessert]} is: ".colorize(:color => :yellow)
  total = @main_arr[:cost] + @side_arr[:cost] + @side2_arr[:cost] + @dessert_arr[:cost]
  puts number_to_currency(total)
  more_options
end

def more_options
  puts "\nWould you like anything else? (yes/no)".colorize(:color => :yellow)
  if user_input == 'yes'
    puts "Alright let's go back to the beginning!".colorize(:color => :light_blue)
    main_menu
  else
    wallet_end
  end
end

def wallet_end
  puts "\nOk, your change is: ".colorize(:color => :light_blue)
  change = @wallet_amount - @main_arr[:cost] - @side_arr[:cost] - @side2_arr[:cost] - @dessert_arr[:cost]
  puts number_to_currency(change)
  puts "Enjoy the meal! We'll see you next time!".colorize(:color => :green)
end

def user_input
  print '> '
  gets.strip
end

welcome
