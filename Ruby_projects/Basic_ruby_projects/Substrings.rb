dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(word, dictionary)
    i = 0
    results = Hash.new
    while i < dictionary.length
        if word.downcase.include? dictionary[i].downcase
            results[dictionary[i]] = word.downcase.scan(dictionary[i]).count
        else
            false
        end
        i += 1
    end
    puts results
end

substrings("Howdy partner, sit down! How's it going?", dictionary)

=begin

.1) Search against the dictionary
.2) Allow multiple words in my string
.3) Count items more than once

=end
