require 'spec_helper'

RSpec.describe Pathname2, '#pstrip!' do
  let(:trl_path) { Pathname2.new('/usr/local/bin/') }

  it 'has pstrip! method' do
    expect(trl_path).to respond_to(:pstrip!)
  end

  it 'removes trailing separator' do
    expect(trl_path.pstrip!).to eq('/usr/local/bin')
  end

  it 'modifies the original path' do
    trl_path.pstrip!
    expect(trl_path).to eq('/usr/local/bin')
  end
end
