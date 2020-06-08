require "toml"
require "json"

TOPIC_FILE = "topic.toml"

module DataScanner
    @@topics = [] of Topic

    class Section
        include JSON::Serializable

        # def initialize(pull : JSON::PullParser)
        #     previous_def
        # end

        def string_or_array(item)
            if item.is_a? String
                item = item.as(String).split(",")
            end
            return item
        end

        def format
        end
    end


    class Base
        def load_section(content, section_name, section_class)
            if content.has_key?(section_name)
                output = section_class.from_json(content[section_name].to_json)
                output.format
            else
                output = section_class.from_json("{}") 
            end
            return output
        end
    end


    class Info < Section
        property tid : String = ""
        property name : String= ""
        property title : String = ""
        property aliases : String | Array(String) = [] of String
        property tags : String | Array(String) = [] of String

        def format
            @aliases = string_or_array(@aliases)
            @tags = string_or_array(@tags)
        end
    end


    class Git < Section
        property url : String = ""
        property branch : String = ""
    end


    class Links < Section
        property linkedin : String = ""
        property facebook : String = ""
        property telegram : String = ""
        property websites : String | Array(String) = [] of String

        def format
            @websites = string_or_array(@websites)
        end
    end


    class Profile < Section
        property intro_video : String = ""
        property intro_text_purpose : String = ""
        property intro_text_experience : String = ""
        property comment : String = ""
    end


    class Filter < Section
        property includes : String | Array(String) = [] of String
        property excludes : String | Array(String) = [] of String

        def format
            @includes = string_or_array(@includes)
            @excludes = string_or_array(@excludes)
        end
    end


    class Include < Section
        property topic_ids : String | Array(String) = [] of String
        property filter : Filter
        
        def initialize(pull : JSON::PullParser)
            @filter = Filter.from_json("{}")
        end
        
        def format
            @topic_ids = string_or_array(@topic_ids)
        end
    end


    class PersonInfo < Section
        property full_name : String = ""
        property countries : String | Array(String) = [] of String
        property cities : String | Array(String) = [] of String
        property companies : String | Array(String) = [] of String
        property aliases : String | Array(String) = [] of String
        property tags : String | Array(String) = [] of String

        def format
            @countries = string_or_array(@countries)
            @cities = string_or_array(@cities)
            @companies = string_or_array(@companies)
            @aliases = string_or_array(@aliases)
            @tags = string_or_array(@tags)
        end
    end


    class PersonCircle < Section
        property tid : String = ""
        property name : String = ""
        property membership : String = ""
        property aliases : String | Array(String) = [] of String
        property tags : String | Array(String) = [] of String
        property profile : Profile

        def initialize(pull : JSON::PullParser)
            @profile = Profile.from_json("{}")
        end

        def format
            @aliases = string_or_array(@aliases)
            @tags = string_or_array(@tags)
        end
    end


    class Topic < Base
        property path : String
        property info : Info
        property links : Links
        property git : Git
        property sites : Array(Site) = [] of Site
        property persons : Array(Person) = [] of Person
        property circles : Array(Circle) = [] of Circle

        def initialize (@path)
            content = TOML.parse_file(@path).as(Hash)
            @info = load_section(content, "info", Info)
            @links = load_section(content, "links", Links)
            @git = load_section(content, "git", Git)

            sites_dir = File.join(File.dirname(@path), "sites")
            if Dir.exists?(sites_dir)
                Dir.children(sites_dir).each do |name|
                    path = File.join(sites_dir, name)
                    @sites << Site.new path
                end                
            end

            persons_dir = File.join(File.dirname(@path), "persons")
            if Dir.exists?(persons_dir)
                Dir.children(persons_dir).each do |name|
                    path = File.join(persons_dir, name)
                    @persons << Person.new path
                end                
            end

            circle_dir = File.join(File.dirname(@path), "circles")
            if Dir.exists?(circle_dir)
                Dir.children(circle_dir).each do |name|
                    path = File.join(circle_dir, name)
                    @circles << Circle.new path
                end                
            end
        end
    end


    class Person < Base
        property path : String
        property info : PersonInfo
        property profile : Profile
        property links : Links
        property circles : Array(PersonCircle) = [] of PersonCircle

        def initialize (@path)
            content = TOML.parse_file(@path).as(Hash)
            @info = load_section(content, "info", PersonInfo)
            @links = load_section(content, "links", Links)
            @profile = load_section(content, "profile", Profile)

            if content.has_key?("circle")
                circles = content["circle"].as(Array)
                circles.each do |item|
                    @circles << PersonCircle.from_json(item.to_json)
                end
            end
        end
    end


    class Circle < Base
        property path : String
        property info : Info
        property profile : Profile
        property links : Links

        def initialize (@path)
            content = TOML.parse_file(@path).as(Hash)
            @info = load_section(content, "info", Info)
            @links = load_section(content, "links", Links)
            @profile = load_section(content, "profile", Profile)
        end
    end


    class Site < Base
        property path : String
        property info : Info
        property links : Links
        property includes : Array(Include) = [] of Include

        def initialize (@path)
            content = TOML.parse_file(@path).as(Hash)
            @info = load_section(content, "info", Info)
            @links = load_section(content, "links", Links)

            if content.has_key?("includes")
                includes = content["includes"].as(Array)
                includes.each do |item|
                    @includes << Include.from_json(item.to_json)
                end
            end
        end
    end


    def self.scan(path : String)
        @@topics = [] of Topic
        self.walk(path)
        @@topics
    end

    def self.walk(path : String)
        unless Dir.exists?(path)
            raise ("directory is not found")
        end

        Dir.children(path).each do |name|
            child_path = File.join(path, name)
            if File.file? child_path
                if name == TOPIC_FILE
                    topic = Topic.new(child_path)
                    @@topics << topic
                end
            else
                walk(child_path)
            end
        end
    end
end

data = DataScanner.scan "/home/ahelsayd/data/test"
pp data[0].sites[0]

# d = TOML.parse_file("/home/ahelsayd/crystalserver/specs/data_formats/schemas/publish/person.toml").as(Hash)
# pp d