########################################################################
# aref_spec.rb
#
# Specs for the Pathname2#append method.
########################################################################
require 'spec_helper'
require 'pathname2'

RSpec.describe Pathname2, :unix => true, :aref => true do
  let(:abs_path){ described_class.new('/usr/local/bin') }
  let(:rel_path){ described_class.new('usr/local/bin') }

  example "[] with index works as expected for absolute path" do
    expect(abs_path[0]).to eq("/usr")
    expect(abs_path[1]).to eq("local")
    expect(abs_path[-1]).to eq("bin")
  end

  example "[] with index works as expected for relative path" do
    expect(rel_path[0]).to eq("usr")
    expect(rel_path[1]).to eq("local")
    expect(rel_path[-1]).to eq("bin")
  end

  example "[] with index out of range returns nil" do
    expect(abs_path[10]).to be_nil
  end

  example "[] with range argument works as expected for absolute path" do
    expect(abs_path[0..1]).to eq("/usr/local")
    expect(abs_path[0..2]).to eq("/usr/local/bin")
    expect(abs_path[1..2]).to eq("local/bin")
    expect(abs_path[0..-1]).to eq(abs_path)
  end

  example "[] with range argument works as expected for relative path" do
    expect(rel_path[0..1]).to eq("usr/local")
    expect(rel_path[0..2]).to eq("usr/local/bin")
    expect(rel_path[1..2]).to eq("local/bin")
    expect(rel_path[0..-1]).to eq(rel_path)
  end

  example "[] with index and length works as expected for absolute path" do
    expect(abs_path[0,1]).to eq("/usr")
    expect(abs_path[0,2]).to eq("/usr/local")
    expect(abs_path[1,2]).to eq("local/bin")
  end

  example "[] with index and length works as expected for relative path" do
    expect(rel_path[0,1]).to eq("usr")
    expect(rel_path[0,2]).to eq("usr/local")
    expect(rel_path[1,2]).to eq("local/bin")
  end
end
