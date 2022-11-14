using Printf

# calculates if n is a prime number
function prime(n)
	for i in 2:n
		if i == n
			continue
		end
		# n is divisible by an integer other than 1 and itself
		if n % i == 0
			@printf("%d is prime, divisible by %d\n", n, i)
			return true
		end
	end
	@printf("%d is not prime\n", n)
	return false
end

# main function to calculate if numbers 1 to 1000000 are prime
function main()
	# used to determine how long it takes to calculate the prime numbers
	@time begin
		for i in 1:1000000
			prime(i)
		end
	end
end

main() # calls the main function
