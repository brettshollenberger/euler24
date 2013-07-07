module Output
  class Outputter

    def initialize(final_perm, elapsed)
      @final_perm = final_perm
      @elapsed = elapsed
      call_output
    end

    def call_output
      raise "Abstract method call_output called"
    end

  end
end
