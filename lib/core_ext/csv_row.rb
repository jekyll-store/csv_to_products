# Older implementations called #row even if other wasn't a CSV::Row

class CSV
  class Row
    def ==(other)
      return @row == other.row if other.is_a? CSV::Row
      @row == other
    end
  end
end
