class Game
  attr_accessor :code, :round, :who
  def start
    @code = Colors.new
    @who = Choosing_role.new
    @who.choose_your_role
    if @who.choice == "code maker"
      code.player_choose_code
      @round = Rounds.new.round(@code, @who)
    else
      @code.computer_choose_code
      puts "Code breaker, you must crack the code. Choose from the following colors: \n\n#{code.color1}\n#{code.color2}\n#{code.color3}\n#{code.color4}\n#{code.color5}\n#{code.color6}\n\n"
      @round = Rounds.new.round(@code, @who)
    end
  end
end

class Rounds
  attr_accessor :code, :current_round, :hints, :correct_position
  def round(code, who)
    @code = code
    @current_round = 1
    total_rounds = 12
    @guess = []
    while @current_round <= total_rounds
      puts "There are #{total_rounds - @current_round} chances remaining to break the code after this, what is the code breakers guess?"
      counter = 0
      @correct_position = 0
      puts
      correct_color = 0
      if who.choice == "code maker" && @guess.length != 0
        a = 0
        other = []
        while a < 4
          if @guess[a] == "..#{code.arr2[a]}"
            @guess[a] = @code.arr2[a]
            other << @guess[a]
          elsif @guess[a] == ".#{code.arr2[0]}"
            @guess[a] = code.arr2[0]
            other << @guess[a]
          elsif @guess[a] == ".#{code.arr2[1]}"
            @guess[a] = code.arr2[1]
            other << @guess[a]
          elsif @guess[a] == ".#{code.arr2[2]}"
            @guess[a] = code.arr2[2]
            other << @guess[a]
          elsif @guess[a] == ".#{code.arr2[3]}"
            @guess[a] = code.arr2[3]
            other << @guess[a]
          else
            @guess[a] = @code.arr.sample
            other << @guess[a]
          end
          a += 1
        end
        while other.length != 0
          b = 0
          g = 0
          while b < 4
            if @guess[b] == code.arr2[b]
              @guess[b] = other[0]
              b += 1
              other.shift
            elsif @guess[b] == other[0]
              other.shift
              other << @guess[b]
              g += 1
              if g == 5
                @guess[b] = other[0]
                other.shift
                b += 1
                g = 0
              end
            else
              @guess[b] = other[0]
              b += 1
              other.shift
            end
          end
        end
        puts @guess
      elsif who.choice == "code breaker"
        @guess = []
        4.times { @guess << gets.chomp }
      else
        g = 0
        while g < 4
          @guess[g] = @code.arr.sample
          g += 1
        end
      end
      puts
      @hints = Red_and_white_pegs.new.hints(counter, @guess, @correct_position, correct_color, @code, @current_round, who)
      @current_round += 1
    end
  end
end

class Choosing_role
  attr_accessor :choice
  def initialize
    @choice = ""
  end
  def choose_your_role
    puts "Do you want to be the code maker or code breaker?"
    until @choice == "code maker" || @choice == "code breaker"
      @choice = gets.chomp
      if @choice == "code maker"
        puts "Sweet! Let's get you setup with your options."
      elsif @choice == "code breaker"
      else
        puts "Sorry, I didn't quite get that. Could you type it again?"
      end
    end
  end
end

class Colors
  attr_accessor :color1, :color2, :color3, :color4, :color5, :color6, :arr2, :player_color1, :player_color2, :player_color3, :player_color4, :arr
  def initialize
    @color1 = "blue"
    @color2 = "green"
    @color3 = "yellow"
    @color4 = "red"
    @color5 = "white"
    @color6 = "black"
    @arr = [@color1, @color2, @color3, @color4, @color5, @color6]
    @arr2 = []
  end
  def computer_choose_code
    4.times { @arr2 << @arr.sample }
  end
  def player_choose_code
    puts "Choose a 4 length combination from the following colors. You can choose multiple of the same color. Choose between \n\n#{@color1}\n#{@color2}\n#{@color3}\n#{@color4}\n#{@color5}\n#{@color6}\n\n"
    @player_color1 = gets.chomp
    @player_color2 = gets.chomp
    @player_color3 = gets.chomp
    @player_color4 = gets.chomp
    @arr2 = [@player_color1, @player_color2, @player_color3, @player_color4]
    puts "Your chosen code is #{@arr2[0]}, #{@arr2[1]}, #{@arr2[2]}, #{@arr2[3]}."
  end
end

class Red_and_white_pegs
  attr_accessor :correct_position
  def hints(counter, guess, correct_position, correct_color, code, current_round, who)
    e = 0
    @correct_position = correct_position
    while e != 1 
      while counter != 4
        if guess[counter] == code.arr2[counter]
          guess[counter] = "..#{guess[counter]}"
          code.arr2[counter] = "..#{guess[counter]}"
          @correct_position += 1
          counter += 1
        else
          counter += 1
        end
      end
      counter = 0
      while counter != 4
        t = 0
        if code.arr2.include? guess[counter]
          while t != 4
            if code.arr2[t] == guess[counter]
              guess[counter] = ".#{guess[counter]}"
              code.arr2[t] = ".#{guess[counter]}"
              t += 1
              correct_color += 1
            else
              t += 1
            end
          end
          counter += 1
        else
          counter += 1
        end
      end
        code.arr2.map! { |x| x.gsub(/[[:punct:]]/, "") }
        puts "#{@correct_position} of these are the correct color in the correct place."
        puts "#{correct_color} of these are the correct color in the wrong place."
        e += 1
        puts
        win = Winnable.new.win_checker(@correct_position, current_round, code)
    end
  end
end

class Winnable
  def win_checker(correct_position, current_round, code)
    if correct_position == 4
      puts "The code breaker wins!\nThe code was: \n#{code.arr2[0]}\n#{code.arr2[1]}\n#{code.arr2[2]}\n#{code.arr2[3]}"
      exit
    elsif current_round == 12
      puts "The code maker wins!\nThe code was: \n#{code.arr2[0]}\n#{code.arr2[1]}\n#{code.arr2[2]}\n#{code.arr2[3]}"
      exit
    else
    end
  end
end