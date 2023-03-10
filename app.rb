# file: app.rb
require 'sinatra'
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  
  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)

    #response = albums.map do |album|
    #  album.title
    
    #end.join(', ')
  
    #return response
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new

    @artist = repo.find(params[:id])

    return erb(:artist)
  end
  
  
  post '/albums' do
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)

    return ''
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

    #response = artists.map do |artist|
    #  artist.name
    #end.join(', ')
    return erb(:artists)
  end
  
  post '/artists' do
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    

    repo.create(new_artist)

    return ''
  end
end
