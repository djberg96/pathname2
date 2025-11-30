########################################################################
# pstrip_spec.rb
#
# Specs for the Pathname2#pstrip and Pathname2#pstrip! methods.
########################################################################
require 'spec_helper'
require 'pathname2'

RSpec.describe Pathname2, :unix => true, :pstrip => true do
  before(:context) do
    @trl_path = described_class.new('/usr/local/bin///')
  end

  context "pstrip" do
    example "pstrip method is defined" do
      expect(@trl_path).to respond_to(:pstrip)
    end

    example "pstrip returns the expected value" do
      expect(@trl_path.pstrip).to eq('/usr/local/bin')
    end

    example "pstrip does not modify the receiver" do
      @trl_path.pstrip
      expect(@trl_path).to eq('/usr/local/bin///')
    end
  end

  context "pstrip!" do
    example "pstrip! method is defined" do
      expect(@trl_path).to respond_to(:pstrip!)
    end

    example "pstrip returns the expected value" do
      expect(@trl_path.pstrip!).to eq('/usr/local/bin')
    end

    example "pstrip! modifies the receiver" do
      @trl_path.pstrip!
      expect(@trl_path).to eq('/usr/local/bin')
    end
  end
end
