require "msgpack"
require "../schema"
require "../types"

struct Schema::Log < Schema::Schema
    property url : Url = Url.new "twin.log"
    property time : T
    property logs : S
end
