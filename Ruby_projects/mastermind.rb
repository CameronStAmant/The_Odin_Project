class Player
  def initialize
    @player_1 = "player_1"
    @player_2 = "player_2"
  end
end

class Colors
  attr_reader :color_1, :color_2, :color_3, :color_4, :color_5, :color_6

  def initialize
    @color_1 = "red"
    @color_2 = "blue"
    @color_3 = "green"
    @color_4 = "white"
    @color_5 = "black"
    @color_6 = "yellow"
  end
end

class SecretCode
  attr_reader :choice, :colors, :secret_code

  def initialize 
    @secret_code = []
    @colors = Colors.new
    @choice = ""
  end

  def intro
    puts "Welcome to Mastermind! Would you like to be the codemaker or codebreaker?"
    puts
    @choice = gets.chomp
    puts
    e = 0
    while e == 0
      if @choice == "codemaker"
        e = 1
      elsif @choice == "codebreaker"
        e = 1
      else
        puts "Whoops, could you try entering that again? Would you like to be the codemaker or codebreaker?"
        puts
        @choice = gets.chomp
      end
    end
  end

  def human_generate_secret
    puts "Alright then. Let's have you choose the colors. They can be #{colors.color_1}, #{colors.color_2}, #{colors.color_3}, #{colors.color_4}, #{colors.color_5}, or #{colors.color_6}."
    puts
    @secret_code = []
    while secret_code.count != 6
      secret_combo = gets.chomp
      if secret_combo == colors.color_1 || secret_combo == colors.color_2 || secret_combo == colors.color_3 || secret_combo == colors.color_4 || secret_combo == colors.color_5 || secret_combo == colors.color_6
        @secret_code << secret_combo
      else
        puts
        puts
        puts "Sorry, that is not one of the choices. Try again."
        puts
      end
    end
  end

  def computer_generate_secret
    color_array = [colors.color_1, colors.color_2, colors.color_3, colors.color_4, colors.color_5, colors.color_6]
    while secret_code.count != 6
        secret_code << color_array.sample
    end
  end
end

class Turn
  attr_reader :colors, :secret_code

  def initialize
    @turn_number = 1
    @secret_code = []
    @colors = Colors.new
  end

  def human_turn
    @secret_code = []
    puts "Let's have you guess 6 colors."
    puts
    while secret_code.count != 6
      secret_combo = gets.chomp
      if secret_combo == colors.color_1 || secret_combo == colors.color_2 || secret_combo == colors.color_3 || secret_combo == colors.color_4 || secret_combo == colors.color_5 || secret_combo == colors.color_6
        secret_code << secret_combo
      else
        puts "Sorry, that is not one of the choices. Try again."
      end
    end
  end

  def computer_turn(secret, turn)
    elsewhere_index_array = []
    elsewhere_color_array = []
    array_of_colors = [colors.color_1, colors.color_2, colors.color_3, colors.color_4, colors.color_5, colors.color_6]
    t = 0
    sleep 1
    if turn == 1
      while t != 6
        secret_code << array_of_colors.sample
        t += 1
      end
    else
      while t != 6
        if secret_code[t] == secret[t]
          secret_code[t] = secret[t]
          t += 1
        else
          elsewhere_index_array << t
          elsewhere_color_array << secret_code[t]
          secret_code[t] = ""
          t += 1
        end
      end
      u = 0
      somewhere_in_the_secret = []
      while u < elsewhere_index_array.count
        k = 0
        while k < elsewhere_index_array.count
          if elsewhere_color_array[u] == secret[elsewhere_index_array[k]]
            somewhere_in_the_secret << elsewhere_color_array[u]
            secret[elsewhere_index_array[k]] = ".#{secret[elsewhere_index_array[k]]}"
          end 
          k += 1
        end
        u += 1
      end
      secret.map! { |a| a.gsub(/\./,"") }
      g = 0
      while g < somewhere_in_the_secret.count
        if g + 1 == somewhere_in_the_secret.count
          secret_code[elsewhere_index_array[g]] = somewhere_in_the_secret[0]
        else
          secret_code[elsewhere_index_array[g]] = somewhere_in_the_secret[g + 1]
        end
        g += 1
      end
      m = 0
      while m != 6
        if secret_code[m] == ""
          secret_code[m] << array_of_colors.sample
        end
        m += 1
      end 
    end
  end
end

class Hints

  def initialize
    @red_counter = 0
    @white_counter = 0
    @iterate_over_the_guess = 0
    @iterate_over_the_secret = 0
  end

  def red_hint(codemaker, codebreaker)
    red_counter = 0
    iterate_over_the_secret = 0
    iterate_over_the_guess = 0
    while iterate_over_the_secret <= codemaker.count
      iterate_over_the_guess = 0
      while iterate_over_the_guess < codemaker.count
        if codebreaker[iterate_over_the_guess] == codemaker[iterate_over_the_guess]
          codemaker[iterate_over_the_guess] = ".#{codemaker[iterate_over_the_guess]}"
          codebreaker[iterate_over_the_guess] = "..#{codebreaker[iterate_over_the_guess]}"
          red_counter += 1
        end
        iterate_over_the_guess += 1
      end
      iterate_over_the_secret += 1
    end
    puts "The codemaker places #{red_counter} red pegs."
    iterate_over_the_secret = 0
    iterate_over_the_guess = 0
  end

  def white_hint(codemaker, codebreaker)
    white_counter = 0
    iterate_over_the_guess = 0
    iterate_over_the_secret = 0
    while iterate_over_the_secret <= codemaker.count
      iterate_over_the_guess = 0
      while iterate_over_the_guess < codemaker.count
        if codebreaker[iterate_over_the_guess] == codemaker[iterate_over_the_secret]
          codemaker[iterate_over_the_secret] = ".#{codemaker[iterate_over_the_secret]}"
          codebreaker[iterate_over_the_guess] = "..#{codebreaker[iterate_over_the_guess]}"
          white_counter += 1
        end
        iterate_over_the_guess += 1
      end
      iterate_over_the_secret += 1
    end
    puts "The codemaker places #{white_counter} white pegs."
    iterate_over_the_secret = 0
    iterate_over_the_guess = 0
    codebreaker.map! { |a| a.gsub(/\.\./,"") }
    codemaker.map! { |a| a.gsub(/\./,"") }
  end

end

class Game
 attr_reader :code_path, :turn, :hint

 def initialize
  @code_path = SecretCode.new
  @turn = Turn.new
  @hint = Hints.new
 end

  def play
    number_of_turns = 12
    turn_number = 1
    code_path.intro
    if code_path.choice == "codebreaker"
      puts
      puts "The computer is now generating the code..."
      puts
      code_path.computer_generate_secret 
    else
      code_path.human_generate_secret
    end
    while turn_number <= number_of_turns
      if code_path.choice == "codebreaker"
        turn.human_turn 
      else 
        turn.computer_turn(code_path.secret_code, turn_number)
      end
      if turn.secret_code == code_path.secret_code
        puts
        puts "The codebreaker wins! Their final guess was"
        puts
        puts turn.secret_code
        exit
      else
        turn_number += 1
        puts
        hint.red_hint(code_path.secret_code, turn.secret_code)
        hint.white_hint(code_path.secret_code, turn.secret_code)
        puts
        puts "You have #{number_of_turns - turn_number + 1} turns left."
        puts
      end
    end
    puts "The codemaker wins! The codebreakers final guess was"
    puts turn.secret_code
    puts "----------"
    puts "The secret was #{code_path.secret_code}"
    puts "----------"
  end
end

Game1 = Game.new
Game1.play
