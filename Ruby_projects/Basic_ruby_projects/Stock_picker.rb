def stock_picker(*stock)
    purchased_stock = 0
    sold_stock = 1
    stock_length = stock.length
    results = Hash.new
    while purchased_stock < stock.count
        while sold_stock < stock_length
                results[purchased_stock.to_s + "," + (sold_stock + purchased_stock).to_s] = stock[purchased_stock + sold_stock] - stock[purchased_stock]
                sold_stock += 1
        end
        sold_stock = 1
        purchased_stock += 1
        stock_length -= 1
    end
    puts "[" + results.key(results.values.max) + "]" 
end

stock_picker(17,3,6,9,15,8,6,1,10)

=begin

.1) Have it return an array of two items
.2) Have it find the largest number
.3) Have it find the smallest number
.4) Only sell after it has bought
.5) Don't allow the last number to be a buy day
.6) Don't allow the first number to be a sell day
.7) Have the buy and sell days generate the most profit.

=end
