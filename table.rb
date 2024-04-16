require 'terminal-table'

class Table
  def initialize(names)
    @names = names
  end

  def print_table
    header_items = @names.dup.unshift('v PC \\ User >')
    table = Terminal::Table.new(headings: header_items)

    judge = Judge.new(@names.length)

    @names.each_with_index do |name, i|
      current_row = Array.new(@names.length + 1)
      current_row[0] = name

      @names.each_with_index do |_name, j|
        current_row[j + 1] = judge.decide(i, j)
      end

      table.add_row(current_row)
    end

    puts table
  end
end