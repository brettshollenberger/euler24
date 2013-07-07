module Output
  class ConsoleOutputter < Outputter

    def call_output
      puts "#{@final_perm.join('')} found in #{"%f" % @elapsed} seconds."
    end

  end
end
