# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

List.destroy_all

require 'uri'
require 'net/http'
require 'json'

url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=5")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZDU5NmY1ZDIyOTg4MjU3OTIyNmMzYzAzZTNlMjZkNiIsIm5iZiI6MTc0ODEwMDQ3NS45NTM5OTk4LCJzdWIiOiI2ODMxZTU3YjZkNzA3OGM4NjE0MTM5N2UiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.iRuH55Wvv30SIoozib-XT2F43cWMXo5xD6LcelV02t8'

response = JSON.parse(http.request(request).read_body)
results = response['results']

results.each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

puts "Seeding lists…"

lists = [
  {
    name: "Acción",
    list_image: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Fire_explosions.jpg"
  },
  {
    name: "Romance",
    list_image: "https://cdn-blog.superprof.com/blog_cl/wp-content/uploads/2023/12/pexels-eugenia-remark-19254469-1-scaled.jpg.webp"
  },
  {
    name: "Ciencia Ficción",
    list_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Orion_Nebula_-_Hubble_2006_mosaic_18000.jpg/2048px-Orion_Nebula_-_Hubble_2006_mosaic_18000.jpg"
  },
  {
    name: "Terror",
    list_image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Foggy_Forest_%28256920249%29.jpeg"
  },
  {
    name: "Comedia",
    list_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Mosaic_depicting_theatrical_masks_of_Tragedy_and_Comedy_%28Thermae_Decianae%29.jpg/2525px-Mosaic_depicting_theatrical_masks_of_Tragedy_and_Comedy_%28Thermae_Decianae%29.jpg"
  },
  {
    name: "Western",
    list_image: "https://www.corbetosboots.com/wp-content/uploads/2022/07/silueta-vaquero-equitacion-caballo_67123-866.jpeg"
  }
]

List.create!(lists)

puts "Done! Created #{List.count} lists."
