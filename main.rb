require_relative 'judge'
require_relative 'security'
require_relative 'table'


def check_args(args)
    if args.length < 3 || args.length.even?
      puts 'Invalid options: please pass an odd number of moves (3 or more).'
      return false
    end
  
    if args.length != args.uniq.length
      puts 'Invalid options: all moves must be distinct.'
      return false
    end
  
    true
end
  
def main(args)
    return unless check_args(args)
  
    sec = Security.new
    table = Table.new(args)
    judge = Judge.new(args.length)
  
    game_finished = false
  
    until game_finished
      key = sec.generate_key
      computer_move = SecureRandom.random_number(args.length)
      hmac = sec.generate_hmac(key, args[computer_move])
  
      puts "HMAC: #{hmac}"
  
      puts 'Available Moves:'
      args.each_with_index { |move, i| puts "#{i + 1} - #{move}" }
      puts '0 - Exit'
      puts '? - Help'
  
      print 'Enter your move: '
      ans = STDIN.gets.chomp
  
      case ans
      when '?'
        table.print_table
        puts "\n\n\n"
        next
      when '0'
        game_finished = true
        next
      end
  
      player_move = ans.to_i
  
      unless (1..args.length).include?(player_move)
        puts "\n\n\n"
        next
      end
  
      puts "Your move: #{args[player_move - 1]}"
      puts "Computer move: #{args[computer_move]}"
  
      case judge.decide(computer_move, player_move - 1)
      when Outcome::WIN
        puts 'You win!'
      when Outcome::LOSE
        puts 'You lost!'
      else
        puts 'Draw!'
      end
  
      puts "HMAC key: #{key}"
      puts "\n\n\n"
    end
end
  
main(ARGV)