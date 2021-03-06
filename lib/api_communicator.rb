require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
end

def get_film_names(character)
  character_hash = get_character_movies_from_api(character)
  #binding.pry
  character_hash["results"].map do |character_info|
      if character_info["name"].downcase == character
       character_info["films"]
      end
  end.first

end
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


# def film_title_arr(films_hash)
#       films_hash.map do |film|
#       film_info = RestClient.get(film)
#       film_title = JSON.parse(film_info)["title"]
#     end
# end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  film_title_arr = (films_hash.map do |film|
      film_info = RestClient.get(film)
      film_title = JSON.parse(film_info)["title"]
    end)
#binding.pry  
  film_title_arr.each_with_index do |film_title, idx|
    puts "#{idx+1}. #{film_title}"
  end

end

def show_character_movies(character)
  get_character_movies_from_api(character)
  films_hash = get_film_names(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
