require "./spec_helper"
require "../src/data/models/job"

describe Crystal do
  
  it "Job" do
    c = Crystal::Model::Job.new id=1
    puts c.url
    puts c.to_msgpack
  end
end
