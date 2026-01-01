require 'spec_helper'

class MyPathname2 < Pathname2; end

RSpec.describe Pathname2, 'subclass behavior' do
  let(:mypath) { MyPathname2.new('/usr/bin') }

  it 'returns subclass instance' do
    expect(mypath).to be_a(MyPathname2)
  end

  it 'returns subclass when using +' do
    result = mypath + MyPathname2.new('foo')
    expect(result).to be_a(MyPathname2)
  end

  it 'returns subclass when using realpath' do
    expect(mypath.realpath).to be_a(MyPathname2)
  end

  it 'returns subclass instances in children' do
    expect(mypath.children.first).to be_a(MyPathname2)
  end
end
