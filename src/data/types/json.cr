require "./type"

struct Crystal::Type::JSON < Crystal::Type
    property value : String? = nil
end

alias JSON = Crystal::Type::JSON