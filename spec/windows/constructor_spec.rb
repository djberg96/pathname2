require 'spec_helper'

RSpec.describe Pathname2, '.new' do
  let(:abs_path) { "C:/Users" }
  let(:rel_path) { "Users" }
  let(:url_path) { "file:///C:/Documents%20and%20Settings" }

  it 'handles absolute paths properly' do
    expect(Pathname2.new(abs_path).to_s).to eq("C:\\Users")
  end

  it 'handles relative paths properly' do
    expect(Pathname2.new(rel_path).to_s).to eq("Users")
  end

  it 'handles file URLs properly' do
    expect(Pathname2.new(url_path).to_s).to eq("C:\\Documents and Settings")
  end

  it 'returns a Pathname2 object' do
    expect(Pathname2.new(abs_path)).to be_a(Pathname2)
  end

  it 'handles frozen arguments without issue' do
    expect { Pathname2.new(abs_path.freeze) }.not_to raise_error
  end

  it 'raises an error if string argument is too long' do
    expect { Pathname2.new("foo" * 1000) }.to raise_error(ArgumentError)
  end
end
