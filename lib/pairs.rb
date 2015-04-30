module Pairs
  class << self
    def create(row)
      @pairs = {}

      row.each do |k, v|
        d_k = dehumanize(k)
        next if d_k == 'description'
        next pairs[d_k] = quote_dangerous(v) unless k.include?('[')
        next unless affirmative?(v)
        add_to_array(k, v)
      end

      pretty_pairs
    end

    private

    attr_reader :pairs

    def affirmative?(v)
      %w(y Y 1 true yes Yes).include?(v)
    end

    def add_to_array(k, v)
      k, v = k.scan(/[^\[\]]+/)
      pairs[k] ||= []
      pairs[k] << quote_dangerous(v)
    end

    def pretty_pairs
      pairs.map do |k, v|
        v = "[#{v.join(', ')}]" if v.is_a?(Array)
        "#{k}: #{v}\n"
      end.join
    end

    def dehumanize(s)
      s.to_s.gsub(' ', '_').downcase
    end

    def quote_dangerous(s)
      s =~ /[^\w|.]/ ? "'#{s}'" : s
    end
  end
end
