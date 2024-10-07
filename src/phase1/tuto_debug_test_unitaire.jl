### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ aef19068-a719-4acd-88a3-e3c0ce8554bf
using Test

# ╔═╡ c8071cab-b8b2-4c3a-b871-4556fbf368a6
using Logging

# ╔═╡ 5138eef0-3f2c-11ed-2c56-4559bc023693
md"""
#### Labo #4: Unit tests and Debugger

##### Ressources
* **Unit tests**: [https://docs.julialang.org/en/v1/stdlib/Test/](https://docs.julialang.org/en/v1/stdlib/Test/)
* **Debugger**: 
  + Debugger integrated in VSCode (easy to use): [https://www.julia-vscode.org/docs/stable/userguide/debugging/](https://www.julia-vscode.org/docs/stable/userguide/debugging/)
  + Debugger.jl package: [https://github.com/JuliaDebug/Debugger.jl](https://github.com/JuliaDebug/Debugger.jl)
"""

# ╔═╡ 3ef9ef42-1f75-4030-8f36-c485d1f17798
md"""
##### 1. Debugger
VS Code integrates a debugger for Julia. Here is a detailed [tutorial](https://www.julia-vscode.org/docs/stable/userguide/debugging/) on how to use it.

The [Debugger.jl](https://github.com/JuliaDebug/Debugger.jl) package enables "manual" debugging, and offers similar functionalities than VS Code integrated debugger. It is recommended to use VS Code debugger for it is more user friendly.
"""

# ╔═╡ beae9d6d-5f7b-4c6b-9d97-4c24f8de0d7d
md"""
##### 2. Unit Tests
Unit tests are simple tests that check if a function or an isolated piece of code behaves as intended. A unit test usually checks that a function returns the expected output for one or few different inputs.
The Julia's unit test functionalities are implemented in the Test.jl package"""



# ╔═╡ 1ee51dbd-4aa0-4f0a-98f4-76da811c0422
md"""In this section, we will illustrate unit tests over the fibonacci function, coded naively as:
"""

# ╔═╡ 84bab878-f8ad-4b5c-b5da-badeb63f2ee6
""" (Very) Naive implementation of Fibonacci """
function fibonacci(n::Int)
	fm=0
	fn=1
	for _ = 2:n
		fmem = fn
		fn=fn+fm
		fm=fmem
	end
	return fn
end

# ╔═╡ 443babaf-cd21-4249-bc66-c07ef1cff5a4
md"""
###### 2.1 Basic Unit Test
Let us now try to run some unit tests on `fibonacci`. The fibonacci sequence is 0,1,1,2,3,5,8,13,21,24,55,89,...
In Julia, a unit test are run with `@test` followed by a boolean expression.
Let's define unit tests to check if `fibonacci` returns the correct answer for a couple a sequence indices:
"""

# ╔═╡ c6d31523-9af2-45b6-ae8e-be3c4ccb0436
@test fibonacci(10) == 55

# ╔═╡ 7d11c400-27b3-474e-ab15-d6dfb64b2877
@test fibonacci(11) == 89

# ╔═╡ 7892d555-32fa-4aaf-8c8a-1cc53adda578
md""" The two unit tests above show that the tests have passed, i.e., `fibonacci` returns the correct sequence element at indices 10 and 11. The unit tests also indicates the evaluated expression and what has been evaluated."""

# ╔═╡ 9ba0fa81-87d9-47b1-b40c-bb3b8c54130f
md""" Let's now define another unit test to check if `fibonacci` returns the correct answer for n=0"""

# ╔═╡ 59e8803a-cb80-46bc-8598-9676c6ff88e6
@test fibonacci(0) == 0

# ╔═╡ c33bfd0f-98bf-490c-8d7d-35b0562b5ded
md""" The unit test indicates a failure. The field \"Evaluated\" shows that `fibonacci(0)` returned 1, but 0 was expected, meaning that our implementation of `fibonacci` is not quite good.

❗ **Important:** If a test fails, it returns an error and stop the execution of the code.
"""  

# ╔═╡ 0a32dd21-9d88-40b9-99fd-28704689850d
md"""
###### 2.2 Skipped and Broken Tests
So far, our implementation of `fibonacci` does not handle the case `n=0`. We can decide to skip the unit test for this input for now and decide how to implement better `fibonacci` latter.

There is two ways to do that, using the keywords `broken` or `skip` in the unit test declaration. These two keywords take boolean values.

Let's skip the unit test that fails:
"""

# ╔═╡ ffc7d5ff-e617-4393-9329-7a9a38fc2ace
@test fibonacci(0) == 0 skip=true 

# ╔═╡ 635fae9c-5ace-4b72-abed-21e2fc368fc5
md"""
The unit test output indicates that the test is `Broken`. A `Broken` output means that something's wrong with the test and it has not been performed. In our case, the test is broken since we decided to skip it.

The unit test can be ignored the same way with `broken` keyword:
"""


# ╔═╡ 9cbf5e57-f0f0-416e-90a4-534bcef90680
@test fibonacci(0) == 0 broken=true

# ╔═╡ 1ec02eba-ecff-4c33-92ce-1f8479fdbb3d
md""" `skip` and `broken` do the exact same things: ignoring the test and indicate it as broken if the value is `true`.

Using one or the other is up to the developer to better indicate why a unit test is ignored.
"""

# ╔═╡ afc1342f-4d71-4e34-8f2c-41fc7cf3cb56
md""" Since our implementation of `fibonacci` doesn't handle negative input arguments, we can extend the skip condition to this case """

# ╔═╡ b14deebc-2bd6-426c-baed-70f11d222ce3
md"""
###### 2.3 Test Sets
Julia enables to gather unit tests in test sets. Let's create a proper test set for our `fibonacci` function, that check if the correct values are returned for the first elements of the fibonacci sequence.
"""

# ╔═╡ 2552fed7-37c7-480c-abd4-ee611ea775d4
fibonacci_sequence = [0,1,1,2,3,5,8,13,21,34,55,89]

# ╔═╡ c1d28037-4d35-4f6e-8c3a-bc21c518d9ed
md""" A test set is created with the syntax
```julia
@testset "Test set name" begin
	@test ...
	.
	.
	.

end
```
"""

# ╔═╡ 04dcc729-a1ff-4f05-b8f5-6a2dd447a6b0
fibonacci(2)

# ╔═╡ 558cf23e-fb6f-40a6-8ddb-14e519f6a6f3
@testset "Fibonacci test set" begin
	for n ∈ 1:length(fibonacci_sequence)
		@test fibonacci(n-1) == fibonacci_sequence[n]
	end
end

# ╔═╡ 78553f59-40bd-46f2-8fc9-3f5a9ea0b454
md""" The `@testset` output indicates the name of the test set, the number of tests that have passed and failed. `fibonacci` has passed all the tests except for `n=0` as indicated at the top of the terminal output.

❗ Note that the failed test do not stop the code inside a test set.
"""

# ╔═╡ c536b700-eeaa-4268-937b-98e255c55253
md"""
The test sets can be nested. Let's define a test set for `fibonacci` and two sub test sets.
"""

# ╔═╡ 9d7a2ff1-a770-4071-9640-bea2c037f7eb
@testset "`fibonacci` test sets" begin
	@testset "tests for n≥1" begin
		for n ∈ 2:length(fibonacci_sequence)
			@test fibonacci(n-1) == fibonacci_sequence[n]
		end
	end
	@testset "tests for special cases" begin
		@test fibonacci(0) == 0 skip=true
	end
end

# ╔═╡ 61541fd5-7f06-4766-bcac-9b51f2552e6a


# ╔═╡ c8b5efb8-a6e3-47e4-9862-32ab0b9ce933
md"""
###### 2.4 Testing Log Statements
Unit tests can check that a function returns the expected logging message, for example a warning or an error message.
We need the Logging package to do that. For details about Logging, refers to Lab3.
"""

# ╔═╡ ad251bae-9796-48ca-8111-328763496395
md"""
Let us improve our implementation of `fibonacci` so that it throws an error logging message if the argument is negative. """

# ╔═╡ 3136a526-c356-491a-9694-3eaaf8128099
"""  (somewhat) better implementation of Fibonacci """
function fibonacci2(n::Int)
	n≥0 || (@warn "negative input, returns 0"; return 0)
	@warn "lala"
	fm=0
	fn=1
	for _ = 2:n
		fmem = fn
		fn=fn+fm
		fm=fmem
	end
	return fn
end

# ╔═╡ 6a50ba03-e74b-4d73-8caf-9ad09f715285
md""" Unit test for logging messages are defined as 
```julia
@test_logs (:info,"info message") (:warn,"warn message") (:error,"error message") f(x)==y
```
`@test_logs` returns the value of f(x), and returns an error if the log test fails. 

Let's test a log test on `fibonacci2` to make sure that the correct warning message is sent:
"""

# ╔═╡ 0e7ecb18-0bfd-4b0a-8024-0a7089889a50
@test_logs (:warn,"negative input, returns 0") fibonacci2(-1)

# ╔═╡ 57af013b-3567-4a53-8d5f-4706309baa46
md""" The log test has passed, and `fibonacci2(-1)` is returned. The log test can be nested with a unit test to check that both the logging message and the returned value are as expected: """

# ╔═╡ 9ec6ab9a-6569-45dc-9b3e-138507371bee
@test (@test_logs (:warn,"negative input, returns 0") fibonacci2(-1)) == 0

# ╔═╡ 38fc4d46-fcc8-4f6c-922e-1453c5ddd07a
md""" 
We can now define a full testset for `fibonacci2`:
"""

# ╔═╡ 1086bc93-9db6-4087-847a-2d7ab547e6bb
@testset "`fibonacci2` test sets" begin
	@testset "tests for n≥1" begin
		for n ∈ 2:length(fibonacci_sequence)
			@test fibonacci2(n-1) == fibonacci_sequence[n]
		end
	end
	@testset "tests for special cases" begin
		@test fibonacci2(0) == 0 skip=true # not implemented in fibonacci2
		@test (@test_logs (:warn,"negative input, returns 0") fibonacci2(-1)) == 0
	end
end

# ╔═╡ 5a3d1d47-7aec-48b0-811f-365e5a2cb080
md"""
Note that `@test_log` also counts for a test (passed)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "7f04ae4c9b3cd5197b3509067f6574bac4dc27ab"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ Cell order:
# ╟─5138eef0-3f2c-11ed-2c56-4559bc023693
# ╠═3ef9ef42-1f75-4030-8f36-c485d1f17798
# ╟─beae9d6d-5f7b-4c6b-9d97-4c24f8de0d7d
# ╠═aef19068-a719-4acd-88a3-e3c0ce8554bf
# ╟─1ee51dbd-4aa0-4f0a-98f4-76da811c0422
# ╠═84bab878-f8ad-4b5c-b5da-badeb63f2ee6
# ╟─443babaf-cd21-4249-bc66-c07ef1cff5a4
# ╠═c6d31523-9af2-45b6-ae8e-be3c4ccb0436
# ╠═7d11c400-27b3-474e-ab15-d6dfb64b2877
# ╟─7892d555-32fa-4aaf-8c8a-1cc53adda578
# ╠═9ba0fa81-87d9-47b1-b40c-bb3b8c54130f
# ╠═59e8803a-cb80-46bc-8598-9676c6ff88e6
# ╟─c33bfd0f-98bf-490c-8d7d-35b0562b5ded
# ╟─0a32dd21-9d88-40b9-99fd-28704689850d
# ╠═ffc7d5ff-e617-4393-9329-7a9a38fc2ace
# ╟─635fae9c-5ace-4b72-abed-21e2fc368fc5
# ╠═9cbf5e57-f0f0-416e-90a4-534bcef90680
# ╟─1ec02eba-ecff-4c33-92ce-1f8479fdbb3d
# ╠═afc1342f-4d71-4e34-8f2c-41fc7cf3cb56
# ╟─b14deebc-2bd6-426c-baed-70f11d222ce3
# ╠═2552fed7-37c7-480c-abd4-ee611ea775d4
# ╟─c1d28037-4d35-4f6e-8c3a-bc21c518d9ed
# ╠═04dcc729-a1ff-4f05-b8f5-6a2dd447a6b0
# ╠═558cf23e-fb6f-40a6-8ddb-14e519f6a6f3
# ╟─78553f59-40bd-46f2-8fc9-3f5a9ea0b454
# ╟─c536b700-eeaa-4268-937b-98e255c55253
# ╠═9d7a2ff1-a770-4071-9640-bea2c037f7eb
# ╠═61541fd5-7f06-4766-bcac-9b51f2552e6a
# ╟─c8b5efb8-a6e3-47e4-9862-32ab0b9ce933
# ╠═c8071cab-b8b2-4c3a-b871-4556fbf368a6
# ╟─ad251bae-9796-48ca-8111-328763496395
# ╠═3136a526-c356-491a-9694-3eaaf8128099
# ╟─6a50ba03-e74b-4d73-8caf-9ad09f715285
# ╠═0e7ecb18-0bfd-4b0a-8024-0a7089889a50
# ╟─57af013b-3567-4a53-8d5f-4706309baa46
# ╠═9ec6ab9a-6569-45dc-9b3e-138507371bee
# ╟─38fc4d46-fcc8-4f6c-922e-1453c5ddd07a
# ╠═1086bc93-9db6-4087-847a-2d7ab547e6bb
# ╟─5a3d1d47-7aec-48b0-811f-365e5a2cb080
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
