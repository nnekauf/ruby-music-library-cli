class Song
    #extend Concerns::Findable
    attr_accessor :name, :MusicImporter, :MusicLibraryController
    attr_reader :artist , :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        @artist = artist 
        self.artist=(artist) if artist != nil
        @genre = genre
        self.genre=(genre) unless genre == nil
        save
    end

    def self.all
        @@all
    end

    def save
        @@all <<self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        Song.new(name)
    end

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

     def genre=(genre)
         @genre = genre
         genre.songs << self unless genre.songs.include?(self)
     end

     def self.find_by_name(name)
        @@all.detect{|song| song.name == name }
     end

     def self.find_or_create_by_name(name)
        # names = []
        # @@all.each{|song| names << song.name}
        # if names.include?(name)
        #     Song.find_by_name(name)
        # else
        #     Song.create(name)
        # end
        self.find_by_name(name) || self.create(name) #this will return whichever is true. nil is not true
     end

     def self.new_from_filename(file)
        
        array = file.split(" - ")
        artist, name, genre = array[0], array[1], array[2].gsub( ".mp3" , "")
        genre = Genre.find_or_create_by_name(genre)
        artist = Artist.find_or_create_by_name(artist)
    
        self.new(name, artist, genre)
     end

     def self.create_from_filename(filename)
        
        self.new_from_filename(filename).save
     end
end