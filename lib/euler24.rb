# A permutation is an ordered arrangement of objects. For example,
# 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all
# of the permutations left are listed numerically or alphabetically, we call
# it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

# 012   021   102   120   201   210

# What is the millionth lexicographic permutation of the
# digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

require_relative 'output/outputter_manifest'

class Permutator
  attr_accessor :final_perm, :nth_permutation, :number, :permutations_of_current_digit, :last_num, :start_time, :end_time, :elapsed, :this_digit

  include Output

  def initialize
    @final_perm = []
    @last_num = 0
  end

  def nth_permutation(nth_permutation, number)
    setup(nth_permutation, number)
    permutate
    finish_up
  end

private

  def setup(nth_permutation, number)
    set_vars(nth_permutation, number)
    clock_in
  end

  def set_vars(nth_permutation, number)
    @nth_permutation = nth_permutation
    @number = number
    @permutations_of_current_digit = @number.length - 1
  end

  def clock_in
    @start_time = Time.now
  end

  def permutate
    calculate_this_digit while more_permutations?
    find_last_number
  end

  def more_permutations?
    @permutations_of_current_digit > 0
  end

  def find_last_number
    @last_num += 1 while num_in_perm?(@last_num)
    @final_perm.push(@last_num)
  end

  def calculate_this_digit
    reset_this_digit
    check_next_digit while not_this_digit?
    push_this_digit_to_final_perm
  end

  def not_this_digit?
    @nth_permutation - factorialize(@permutations_of_current_digit) > 0
  end

  def check_next_digit
    @nth_permutation = @nth_permutation - factorialize(permutations_of_current_digit)
    next_legal_digit
  end

  def next_legal_digit
    @this_digit += 1
    @this_digit += 1 while num_in_perm?(@this_digit)
  end

  def push_this_digit_to_final_perm
    @final_perm.push(@this_digit)
    @permutations_of_current_digit -= 1
  end

  def reset_this_digit
    @this_digit = 0
  end

  def factorialize(permutations)
    (1..permutations).inject(:*)
  end

  def num_in_perm?(num)
    @final_perm.include?(num)
  end

  def finish_up
    clock_out
    outputter = Output::ConsoleOutputter.new(@final_perm, @elapsed)
    return @final_perm.join('').to_i
  end

  def clock_out
    @end_time = Time.now
    mark_elapsed
  end

  def mark_elapsed
    @elapsed = @end_time - @start_time
  end

end

# permutator = Permutator.new
# permutator.nth_permutation(1000000, "0123456789")

#2783915460 found in 0.000076 seconds.
