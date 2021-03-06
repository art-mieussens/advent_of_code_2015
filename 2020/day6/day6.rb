# frozen_string_literal: true

# A class representig a group of passengers
class Group
  def initialize
    @answers = {}
    @people_count = 0
  end

  attr_reader :people_count

  def add_person_answers(line)
    line.chomp.each_char do |question|
      @answers[question] ? @answers[question] += 1 : @answers[question] = 1
    end
  end

  def answers_count
    @answers.length
  end

  def common_answers_count
    @answers.select { |_k, v| v == @people_count }.length
  end

  def add_person
    @people_count += 1
  end
end

groups = []
group = Group.new

File.open('input.txt').each_line do |line|
  if line.match?(/^\S+$/)
    group.add_person_answers(line)
    group.add_person
  else
    groups << group
    group = Group.new
  end
end

groups << group

any_total = groups.inject(0) { |sum, g| sum + g.answers_count }
puts "ANY total: #{any_total}"

all_total = groups.inject(0) { |sum, g| sum + g.common_answers_count }
puts "ALL total: #{all_total}"
