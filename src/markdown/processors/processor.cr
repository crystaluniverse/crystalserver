abstract struct Crystal::MD::Processor;
    property show_time : Bool = false
    property include_filters : String = ""
    property exclude_filters : String = ""

    abstract def process
end