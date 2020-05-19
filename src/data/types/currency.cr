require "./type"

struct Crystal::Type::Currency < Crystal::Type
    property value : String? = nil
end

alias C = Crystal::Type::Currency