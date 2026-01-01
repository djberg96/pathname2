require 'spec_helper'

RSpec.describe Pathname2, 'enumerable behavior' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }

  it 'responds to each' do
    expect(abs_path).to respond_to(:each)
  end
end
