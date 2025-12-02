########################################################################
# append_spec.rb
#
# Specs for the Pathname2#append method.
########################################################################
require 'spec_helper'
require 'pathname2'

RSpec.describe Pathname2, :unix => true, :aref => true do
  let(:path){ described_class.new('/usr/local/bin') }

  example "[] with index works as expected" do
    expect(path[0]).to eq("/usr")
    expect(path[1]).to eq("local")
    expect(path[-1]).to eq("bin")
  end

  example "[] with index out of range returns nil" do
    expect(path[10]).to be_nil
  end

  example "[] with range argument works as expected" do
    expect(path[0..1]).to eq("/usr/local")
    expect(path[0..2]).to eq("/usr/local/bin")
    expect(path[1..2]).to eq("local/bin")
    expect(path[0..-1]).to eq(path)
  end

  example "[] with index and length works as expected" do
    expect(path[0,1]).to eq("/usr")
    expect(path[0,2]).to eq("/usr/local")
    expect(path[1,2]).to eq("local/bin")
  end
end
