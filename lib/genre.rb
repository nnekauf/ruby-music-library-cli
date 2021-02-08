class Genre
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
        Genre.new(name)
    end

    def songs
        @songs
    end
    def artists
        all_artists = @songs.collect{|song| song.artist}  
          all_artists.uniq
      end
end