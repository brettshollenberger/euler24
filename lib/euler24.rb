# A permutation is an ordered arrangement of objects. For example,
# 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all
# of the permutations left are listed numerically or alphabetically, we call
# it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

# 012   021   102   120   201   210

# What is the millionth lexicographic permutation of the
# digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

require_relative 'output/outputter_manifest'

class Permutator
  attr_accessor :final_perm, :nth_permutation, :number, :permutations_of_current_digit, :last_num, :start_time, :end_time, :elapsed

  include Output

  def initialize
    @final_perm = []
    @last_num = 0
  end

  def nth_permutation(nth_permutation, number)
    set_vars(nth_permutation, number)
    clock_in
    push_to_perm
    clock_out
    outputter = Output::ConsoleOutputter.new(@final_perm, @elapsed)
    return @final_perm.join('').to_i
  end

private

  def set_vars(nth_permutation, number)
    @nth_permutation = nth_permutation
    @number = number
    @permutations_of_current_digit = @number.length - 1
  end

  def clock_in
    @start_time = Time.now
  end

  def clock_out
    @end_time = Time.now
    mark_elapsed
  end

  def mark_elapsed
    @elapsed = @end_time - @start_time
  end

  def push_to_perm
    while @permutations_of_current_digit > 0
      calc_each_num(@permutations_of_current_digit)
      @permutations_of_current_digit -= 1
    end
    last_num_in_perm
  end

  def last_num_in_perm
    while num_in_perm?(@last_num)
      @last_num += 1
    end
    @final_perm.push(@last_num)
  end

  def calc_each_num(perms)
    num = 0
    while @nth_permutation - factorialize(perms) > 0
      @nth_permutation = @nth_permutation - factorialize(perms)
      num += 1
      while num_in_perm?(num)
        num += 1
      end
    end
    @final_perm.push(num)
  end

  def factorialize(nth_permutation)
    (1..nth_permutation).inject(:*)
  end

  def num_in_perm?(num)
    @final_perm.each do |in_the_perm|
      if num == in_the_perm
        return true
      end
    end
    return false
  end

end

# permutator = Permutator.new
# permutator.nth_permutation(1000000, "0123456789")

#2783915460 found in 0.000076 seconds.
