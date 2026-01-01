require 'spec_helper'

class MyPathname2 < Pathname2; end

RSpec.describe Pathname2, 'miscellaneous Windows tests' do
  let(:mypath) { MyPathname2.new(Dir.pwd) }

  describe 'subclasses' do
    it 'return instances of that subclass' do
      expect(mypath).to be_a(MyPathname2)
      expect(mypath + MyPathname2.new('foo')).to be_a(MyPathname2)
      expect(mypath.realpath).to be_a(MyPathname2)
    end
  end

  describe 'custom pn method' do
    it 'works as expected' do
      expect(Kernel).to respond_to(:pn)
      expect(pn { 'c:\foo' }).to be_a(Pathname2)
      expect(pn { 'c:\foo' }).to eq('c:\foo')
    end
  end
end
