movie_id = 1
serie_id = 1

100.times do
  Movie.create(
    title: "Movie #{movie_id}",
    description: "What happens in movie #{movie_id}, stays in movie #{movie_id}",
    rating: 0,
    duration: rand(90..180),
    price: rand(5..25),
    status: ["coming_soon", "preorder", "billboard"].sample,
    playback: 0
  )
  movie_id += 1
end

100.times do
  Serie.create(
    title: "Serie #{serie_id}",
    description: "What happens in serie #{serie_id}, stays in serie #{serie_id}",
    rating: 0,
    price: rand(5..25),
    status: ["coming_soon", "preorder", "billboard"].sample
  )
  number_episodes = rand(10..30)
  episode_id = 1
  number_episodes.times do
    Episode.create(
      title: "Episode #{episode_id} is the best one of Serie #{serie_id}",
      description: "Believe me, Episode #{episode_id} of Serie #{serie_id} is incredible",
      duration: rand(45..120),
      playback: rand(4..400),
      serie_id: serie_id
    )
    episode_id += 1
  end
  serie_id += 1
end

rentals_id = 1

200.times do
  Rental.create(
    paid_price: rand(5..50),
    rentable_type: ["Movie", "Serie"].sample,
    rentable_id: [rand(1..(movie_id-1)), rand(1..(serie_id-1))].sample
  )
  rentals_id += 1
end

# Create users
User.destroy_all
User.create(name: 'Valeria', email: 'valevassallo1@gmail.com', password: '123456')
User.create(name: 'Val', email: 'valevassallo1+hi@gmail.com', password: '123456')