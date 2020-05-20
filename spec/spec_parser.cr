require "./spec_helper"
require "../src/markdown/parser"

describe Crystal do
  
  md = %(
```3|only text, is just a message # remarks```
Hello tags <<color:red group:thisone category:performance.hd description:'sss sss'>> end tags [$30:$50]  ## remarks

```toml $schemaurl($twinid.$topicid.$id)
  here some data in yaml, toml or json
```)
    
  it "Processor" do
    c = Crystal::MD::Parser.new
    c << md
    c.process 0
  end

end