def fibs(n)
  a, b = 0, 1
  (n - 1).times do
    c = a
    a = b
    b = a + c
  end
  b
end

p fibs(5)
p fibs(6)

def fibs_rec(n)
  if n == 0
    0
  elsif n == 1
    1
  else
    fibs_rec(n - 1) + fibs_rec(n - 2)
  end
end

p fibs_rec(5)
p fibs_rec(6)