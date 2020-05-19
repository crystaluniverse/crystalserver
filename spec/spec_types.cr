require "./spec_helper"
require "../src/data/types"

describe Crystal do
  
  it "Currency" do
    c = Crystal::Type::Currency.new "40 USD"
    c.value.should eq("40 USD")
    puts c.to_msgpack
  end
end
