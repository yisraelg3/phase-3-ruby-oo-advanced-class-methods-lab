require 'pry'
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    new_song = self.new
    new_song.save
    new_song
  end

  def self.new_by_name(song_name)
    song = Song.new
    song.name = song_name
    song
  end

  def self.create_by_name(song_name)
    song = self.create
    song.name = song_name
    song
  end

  def self.find_by_name(song_name)
    Song.all.find{|song| song.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    if Song.find_by_name(song_name)
      Song.find_by_name(song_name)
    else
      Song.create_by_name(song_name)
    end
  end

  def self.alphabetical
    self.all.sort_by{|song| song.name}
  end

  def self.new_from_filename(filename) 
    parsed_filename = filename.split(' - ')
    artist = parsed_filename[0]
    name = parsed_filename[1].chomp('.mp3')

    new_song = Song.new_by_name(name)
    new_song.artist_name = artist
    new_song
  end

  def self.create_from_filename(filename) 
    parsed_filename = filename.split(' - ')
    artist = parsed_filename[0]
    name = parsed_filename[1].chomp('.mp3')

    new_song = Song.find_or_create_by_name(name)
    new_song.artist_name = artist
    new_song
  end

  def self.destroy_all
    self.all.clear
  end
end