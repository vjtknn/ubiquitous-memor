class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    initialize_record(record: record)
    @brackets = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
    @openings = @brackets.keys
    @closings = @brackets.values
    @stack = []

    @title.each_char.with_index do |char, i|
      if @openings.include?(char)
        error_message if @closings.include? @title[i + 1]
        @stack << char
      elsif @closings.include?(char)
        if @stack.empty? || @brackets[@stack.pop] != char
          error_message
        end
      end
    end
    error_message unless @stack.empty?
  end

  private

  def initialize_record(record:)
    @record = record
    @title = record.title
  end
  def error_message
    @record.errors[:title] << 'mismached bracket'
  end
end
