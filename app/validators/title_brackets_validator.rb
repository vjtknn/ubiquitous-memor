class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    @title = record.title
    @brackets = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
    @openings = @brackets.keys
    @closings = @brackets.values
    @stack = []

    record.title.each_char.with_index do |char, i|
      if @openings.include?(char)
        record.errors[:title] << 'mismached bracket' if @closings.include? @title[i+1]
        @stack << char
      elsif @closings.include?(char)
        if @stack.empty? || @brackets[@stack.pop] != char
          record.errors[:title] << 'mismached bracket'
        end
      end
    end
    record.errors[:title] << 'mismached bracket' if !@stack.empty?
  end
end
