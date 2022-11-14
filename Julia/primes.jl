using Printf

function prime(n)
	for i in 2:n
		if i == n
			continue
		end
		if n % i == 0
			@printf("%d is prime, divisible by %d\n", n, i)
			return
		end
	end
	@printf("%d is not prime\n", n)
end


function main()
	@time begin
		for i in 1:1000000
			prime(i)
		end
	end
end

main() # calls the main function
