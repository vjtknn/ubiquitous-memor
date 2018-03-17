class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    initialize_record(record: record)
    initialize_brackets_and_stack
    validate_mismached_or_empty_brackets_in_title
  end

  private

  def initialize_record(record:)
    @record = record
    @title = record.title
  end

  def initialize_brackets_and_stack
    @brackets = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
    @openings = @brackets.keys
    @closings = @brackets.values
    @stack = []
  end

  def validate_mismached_or_empty_brackets_in_title
    @title.each_char.with_index do |char, i|
      if @openings.include?(char)
        error_message if @closings.include? @title[i + 1]
        @stack << char
      elsif @closings.include?(char)
        error_message if @stack.empty? || @brackets[@stack.pop] != char
      end
    end
    error_message unless @stack.empty?
  end

  def error_message
    @record.errors[:title] << 'mismached bracket'
  end
end
