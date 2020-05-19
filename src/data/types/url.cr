require "./type"

struct Crystal::Type::URL < Crystal::Type
    property value : String? = nil
end

alias Url = Crystal::Type::URL