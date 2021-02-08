require "pry"
class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs
    @@all = []
    
    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def self.all
        @@all
    end

    def save
        @@all <<self
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        Artist.new(name)
    end
    
    def songs
        @songs
    end
#binding.pry
    def add_song(song)
        if song.artist == nil
            song.artist = self
        end
        if !@songs.include?(song)
            @songs << song
        end
    end

    def genres
      all_genres = @songs.collect{|song| song.genre}  
        all_genres.uniq
    end
end