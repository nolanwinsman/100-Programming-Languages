using Printf
using Distributed


# calculates if n is a prime number
function prime(n)
	for i in 2:n
		if i == n
			continue
		end
		# n is divisible by an integer other than 1 and itself
		if n % i == 0
			@printf("%d is prime, divisible by %d\n", n, i)
			
		end
	end
	@printf("%d is not prime\n", n)
	return false
end

function primes_to_n(n)
	@distributed for i in 1:n
		prime(i)
	end
end

# main function to calculate if numbers 1 to 1000000 are prime
function main()
	# used to determine how long it takes to calculate the prime numbers
	@time begin
		primes_to_n(100_000)
	end
end

main() # calls the main function
