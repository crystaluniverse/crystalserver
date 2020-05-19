require "msgpack"

abstract struct Crystal::Schema
    include MessagePack::Serializable
    property id : Int32
    def initialize(@id); end
    
end


abstract struct Crystal::Type
    include MessagePack::Serializable
    def initialize(@value : String? = nil); end
end
