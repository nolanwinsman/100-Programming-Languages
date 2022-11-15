using Printf
using Distributed
using BenchmarkTools

# calculates if n is a prime number
function prime(n)
	for i in 2:n
		if i == n
			continue
		end
		# n is divisible by an integer other than 1 and itself
		if n % i == 0
			#@printf("%d is prime, divisible by %d\n", n, i)
			return true
		end
	end
	#@printf("%d is not prime\n", n)
	return false
end

function normal_calculating_primes(n)
		for i in 1:n
			prime(i)
		end
end

function multi_threading_primes(n)
		Threads.@threads for i in 1:n
			prime(i)
		end
end

function multi_processing_primes(n)
	@distributed for i in 1:n
		prime(i)
	end
end

# main function to calculate if numbers 1 to 1000000 are prime
function main()
	n = 10_000
	println("Normal")
	@btime normal_calculating_primes($n)
	println("Multithreading")
	@btime multi_threading_primes($n)
	println("Multiprocessing")
	# @btime multi_processing_primes($n)
end

main() # calls the main function
