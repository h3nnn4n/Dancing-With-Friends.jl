using Distributions

type Dancer
    x :: Float64
    y :: Float64
    friend :: Int32
    enemy :: Int32
end

Dancer(population_size) = Dancer(rand(Normal(0.0, 10.0)), rand(Normal(0.0, 10.0)), rand(1:population_size), rand(1:population_size))
