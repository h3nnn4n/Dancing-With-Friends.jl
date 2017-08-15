include("types.jl")

function init_population(population_size :: Integer)
    population = Array{Dancer, 1}(population_size)

    for i in 1:population_size
        population[i] = Dancer(population_size)
    end

    return population
end

dist(x1, y1, x2, y2) = sqrt((x1 - x2)^2.0 + (y1 - y2)^2.0)

function main()
    population_size = 100
    dancers = init_population(population_size)

    center_x = 1.0
    center_y = 1.0

    friend_stop = 0.01
    center_stop = 0.01
    enemy_stop  = 0.01

    friend_speep = 0.6
    enemy_speed  = 0.1
    center_speed = 0.05

    iters = 100

    for iter in 1:iters
        for i in 1:population_size
            target = dancers[i]
            friend = dancers[target.friend]
            enemy  = dancers[target.enemy]
            f_distance = dist(target.x, target.y, friend.x, friend.y)
            e_distance = dist(target.x, target.y, enemy.x , enemy.y )
            c_distance = dist(target.x, target.y, center_x, center_y)

            t  = [target.x, target.y]
            f  = [friend.x, friend.y]
            en = [enemy.x, enemy.y]
            c  = [center_x, center_y]

            if f_distance > friend_stop
                angle = acos(dot(t, f) / (norm(t) * norm(f)))
                dancers[i].x += cos(angle) * friend_speep
                dancers[i].y += sin(angle) * friend_speep
            end

            if e_distance > enemy_stop
                angle = acos(dot(t, en) / (norm(t) * norm(en)))
                dancers[i].x += cos(angle) * -enemy_speed
                dancers[i].y += sin(angle) * -enemy_speed
            end

            if c_distance > center_stop
                angle = acos(dot(t, c) / (norm(t) * norm(c)))
                dancers[i].x += cos(angle) * center_speed
                dancers[i].y += sin(angle) * center_speed
            end
            #=@printf("%f %f\n", dancers[i].x, dancers[i].y)=#
        end
        #=@printf("\n")=#
    end

    for i in 1:population_size
        @printf("%f %f\n", dancers[i].x, dancers[i].y)
    end
end

main()
