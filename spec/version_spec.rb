require 'spec_helper'

RSpec.describe Pathname2, 'VERSION' do
  it 'is set to expected value' do
    expect(Pathname2::VERSION).to eq('2.0.0')
  end

  it 'is frozen' do
    expect(Pathname2::VERSION).to be_frozen
  end
end
