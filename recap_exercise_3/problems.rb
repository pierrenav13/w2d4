require 'byebug'
def no_dupes?(arr)
    hash = Hash.new(0)
    arr.each {|ele| hash[ele] += 1}
    hash.select {|k, v| v == 1}.keys
end

# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    i = 0
    return true if arr.length == 1

    while i < arr.length - 1
        return false if arr[i] == arr[i + 1]
        i += 1
    end
    true
end

# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                             # => true

def char_indices(str)
    hash = Hash.new {|h, k| h[k] = [] }
    str.each_char.with_index {|char, idx| hash[char] << idx}
    hash
end

# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    hash = Hash.new(0)

    s = str.split('')
    s.each_with_index do |char, idx| 
        if (idx < s.length - 1) && char == s[idx + 1]
            hash[char] += 1 
        elsif (idx == s.length - 1 || char != s[idx + 1]) && char == s[idx - 1]
            hash[char] += 1
        end
    end

    max_char = hash.inject do |accum, (k, v)|
        if accum == nil
            k
        else
            k if hash[accum] <= v
        end
    end
    if hash[max_char] != nil
        return max_char * hash[max_char] 
    end
    str[-1]
    
end

# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def prime?(num)
    return true if num == 2
    (2...num).each { |x| return false if num % x == 0 }
    true
end

def bi_prime?(num)
    primes = []
    (2...num).each { |x| primes << x if prime?(x) }
    primes.each_with_index do |ele1, idx1|
        primes.each_with_index do |ele2, idx2|
            return true if ele1 * ele2 == num
        end
    end
    false
end

# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
    alphabet = ('a'..'z').to_a
    array = []

    i = 0

    message.each_char do |char|
        idx = alphabet.index(char)
        array << alphabet[(idx + keys[i]) % 26]
        if i < keys.length - 1
            i += 1
        else
            i = 0
        end
    end
    array.join('')
  
end

# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    vowels = 'aeiou'
    array = []
    i = 0

    str.each_char {|char| array << char if vowels.include?(char)}
    str.each_char.with_index do |char, idx|
        if vowels.include?(char)
            str[idx] = array[i - 1]
            i += 1
        end
    end
    str
end

# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"

class String

    def select(&prc)
        str = ''
        self.each_char {|char| str += char if prc.call(char)}
        str
    end

    def map!(&prc)
        self.each_char.with_index {|char, idx| self[idx] = prc.call(char)}
        self
    end

end


def multiply(a, b)
    return 0 if a == 0 || b == 0
    if b > 0
        a + multiply(a, b - 1)
    else
       a + multiply(-a, -b + 1)
    end
end

# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18


