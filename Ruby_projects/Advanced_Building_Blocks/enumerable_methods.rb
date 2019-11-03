module Enumerable
    def my_each
        if block_given?
            if self.is_a?(Array)
                self.length.times { |i| yield(self[i]) }
                self
            else
                self.length.times { |i| yield(self.to_a.at(i)) }
                self
            end
        else
            "#<Enumerator: #{self}:my_each"
        end
    end

=begin
    QA  
        arrays:
            arr = [2,3,4,5]
            arr.my_each { |a| p a }

        hashes:
            hashh = { "two" => "2", "three" => "3" }
            hash.my_each { |a| p a }
=end

    def my_each_with_index
        if block_given?
            if self.is_a?(Array)
                self.length.times { |i| yield(self[i], i) }
                self
            else 
                self.length.times { |i| yield(self.keys[i], self.values[i], i) }
                self
            end
        else
            "#<Enumerator: #{self}:my_each_with_index>"
        end
    end

=begin
    QA
        arrays:
            arr = [2,3,4,5]
            arr.my_each_with_index { |value, index| puts "#{index}: #{value}" }

        hashes:
            hashh = { "two" => "2", "three" => "3" }
            hashh.my_each_with_index { |key, value, index| puts "[\"#{key}\", \"#{value}\", #{index}]" }
=end

    def my_select
        if block_given?
        ary = []
        has = {}
            if self.is_a?(Array)
                self.my_each { |n| yield(n) == true ? ary.push(n) : n }
                ary
            else
                self.my_each { |k, v| yield(k, v) == true ? has[k] = v : nil }
                has
            end
        else
            "#<Enumerator: #{self}:my_select"
        end
    end

=begin
    QA
        arrays:
            arr = [2,3,4,5]
            arr.my_select { |i| i % 2 == 0 }

        hashes:
            hashh = { "two" => 2, "six" => 6, "four" => 4 }
            hashh.my_select { |k, v| v > 3 }
=end

    def my_all?(type = nil)
        ary = []
        has = {}
        if block_given?
            if self.is_a?(Array)
                self.my_each { |n| yield(n) == true ? ary.push(true) : false }
                self.length == ary.length ? (puts "true") : (puts "false")
                ary
            else
                self.my_each { |k, v| yield(k, v) == true ? has[k] = v : (puts "hash") }
                has
            end
        
        elsif type != nil
            self.my_each { |n| n.is_a?(type) ? ary.push(true) : false }
            self.length == ary.length ? (puts "true") : (puts "false")
        
        else
            self.my_each { |n| n != false && n != nil ? ary.push(true) : false }
            self.length == ary.length ? (puts "true") : (puts "false")
        end
    end

=begin
    QA
        array:
            arr = [2,3,4,5]
            arr.my_all? { |i| i >= 3 }
            arr.my_all? { |i| i >= 2 }
            arr.my_all?(Numeric)
            arr1 = [2,3,"hi"]
            arr1.my_all?(Numeric)
            arr2 = [nil, 2]
=end

    def my_any?(type = nil)
        ary = []
        has = {}
        if block_given?
            if self.is_a?(Array)
                self.my_each { |n| yield(n) == true ? ary.push(true) : false }
                ary.length >= 1 ? (puts "true") : (puts "false")
                ary
            else
                self.my_each { |k, v| yield(k, v) == true ? has[k] = v : false }
                has.length >= 1 ? (puts "true") : (puts "false")
                has
            end
        
        elsif type != nil
            self.my_each { |n| n.is_a?(type) ? ary.push(true) : false }
            self.length == ary.length ? (puts "true") : (puts "false")
        
        else
            self.my_each { |n| n != false && n != nil ? ary.push(true) : false }
            ary.length >= 1 ? (puts "true") : (puts "false")
        end
    end

=begin
    QA
        Array:
            arr = [2,3,4,5]
            arr1 = [2,3,"hi"]
            arr2 = [nil, 2]
            arr1.my_any? { |i| i.is_a?(Numeric) }
            arr2.my_any?
            arr2.my_any?(Numeric)
        Hash:
            hashh = { "two" => 2, "six" => 6, "four" => 4 }
            hashh.my_any?
            hashh.my_any? { |k, v| k.is_a?(String) }
            hashh.my_any? { |k, v| k.is_a?(Numeric) }
=end

    def my_none?(type = nil)
        ary = []
        has = {}
        if block_given?
            if self.is_a?(Array)
                self.my_each { |n| yield(n) == true ? ary.push(true) : false }
                ary.length >= 1 ? (puts "false") : (puts "true")
                ary
            else
                self.my_each { |k, v| yield(k, v) == true ? has[k] = v : false }
                has.length >= 1 ? (puts "false") : (puts "true")
                has
            end
        
        elsif type != nil
            self.my_each { |n| n.is_a?(type) ? ary.push(true) : false }
            self.length == ary.length ? (puts "false") : (puts "true")
        
        else
            self.my_each { |n| n != false && n != nil ? ary.push(true) : false }
            ary == nil ? (puts "true") : (puts "false")
            ary
        end
    end

=begin
    QA
        Array:
            arr = [2,3,4,5]
            arr1 = [2,3,"hi"]
            arr2 = [nil, 2]
            arr3 = [nil, false]
            arr1.my_none? { |i| i.is_a?(Numeric) }
            arr2.my_none?
            arr2.my_none?(Numeric)
        Hash:
            hashh = { "two" => 2, "six" => 6, "four" => 4 }
            hash1 = {}
            hashh.my_none?
            hashh.my_none? { |k, v| k.is_a?(String) }
            hashh.my_none? { |k, v| k.is_a?(Numeric) }
=end

    def my_count(specific = nil)
        i = 0
        if block_given?
            self.my_each { |n| yield(n) == true ? i += 1 : i += 0 }
            i
        elsif specific != nil
            self.my_each { |n| n == specific ? i += 1 : i += 0 }
            i
        else
            self.length
        end
    end

=begin
    QA
        Array:
            arr = [2,3,4,2,5,2,2]
            arr.my_count
            arr.my_count(2)
            arr.my_count { |x| x % 2 == 0 }

=end

    def my_map(&pro)
        ary = []
        if block_given?
            self.my_each { |n| ary << yield(n) }
            return ary
        else
            "#<Enumerator: #{self}:my_map"
        end
    end

=begin
    QA
        Array:
            arr = [2,3,4,2,5,2,2]
            arr.my_map { |i| i - 10 }
        Proc:
            my_proc = Proc.new { |x| x * x}
            arr.my_map(&my_proc)
=end

    def my_inject(val = nil, sym = nil)
        result = self[0]
        if val.is_a?(String) || val.is_a?(Symbol)
            sym = val
            val = nil
        end
        if val.is_a?(Integer)
            result = val
        end
        if sym.nil?
            if block_given?
                if val == nil
                    drop(1).my_each { |i| result = yield(result, i) }
                else
                    result = val
                    my_each { |i| result = yield(result, i) }
                end
            end
        else
            if sym == :* || sym == :/
                if val == nil
                    drop(1).my_each { |i| result = result.send(sym, i) }
                else
                    result = val
                    my_each { |i| result = result.send(sym, i) }     
                end
            else
                if val != nil
                    my_each { |i| result = result.send(sym, i) }
                else
                    drop(1).my_each { |i| result = result.send(sym, i) }
                end
            end
        end
        return result
    end

=begin
    QA
        Array:
        arr = [16,2]
        arr.my_inject(:+)
        arr.my_inject(64, :+)
        arr.my_inject { |sum, n| sum + n }  
        arr.my_inject(64) { |sum, n| sum + n }

=end

    def multiply_els
        my_inject(:*)
    end

=begin 
    QA
        [2,4,5].multiply_els
=end

end
