require "./spec_helper"
require "../src/markdown/processors"

describe Crystal do
  
  it "Processor" do
    c = Crystal::MD::StdOutProcessor.new
    c.process.should eq(true)
  end
end
