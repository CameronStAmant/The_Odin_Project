def caesar_cipher(sentence, encrypt_key)
    secret = []
    i = 0
    while i < sentence.length
        if sentence[i].match(/\p{L}/)
            if sentence[i].ord >= 65 && sentence[i].ord <= 90
                secret[i] = sentence[i].ord + encrypt_key
                if secret[i] < 65
                    while secret[i] < 65
                        secret[i] += 26
                    end
                    sentence[i] = secret[i].chr
                    i += 1
                elsif
                    secret[i] > 90
                    while secret[i] > 90
                        secret[i] -= 26
                    end
                    sentence[i] = secret[i].chr
                    i += 1
                else
                    sentence[i] = secret[i].chr
                    i += 1
                end
            else
                secret[i] = sentence[i].ord + encrypt_key
                if secret[i] < 97
                    while secret[i] < 97
                        secret[i] += 26
                    end
                    sentence[i] = secret[i].chr
                    i += 1
                elsif
                    secret[i] > 122
                    while secret[i] > 122
                        secret[i] -= 26
                    end
                    sentence[i] = secret[i].chr
                    i += 1
                else
                    sentence[i] = secret[i].chr
                    i += 1
                end
            end
        else
            i += 1
        end
    end
    
    puts sentence[0..-1]
end

caesar_cipher 'What a string!', 5