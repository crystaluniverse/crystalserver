require "./processor"

struct Crystal::MD::StdOutProcessor < Crystal::MD::Processor

    def process
        true 
    end
end