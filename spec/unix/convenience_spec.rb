require 'spec_helper'

RSpec.describe Pathname2, 'convenience methods' do
  describe 'Kernel#pn' do
    it 'responds to pn' do
      expect(Kernel).to respond_to(:pn)
    end

    it 'creates Pathname2 instance' do
      result = pn { '/foo' }
      expect(result).to be_a(Pathname2)
      expect(result).to eq('/foo')
    end
  end

  describe 'Pathname2.pwd' do
    let(:pwd) { Dir.pwd }

    it 'responds to pwd' do
      expect(Pathname2).to respond_to(:pwd)
    end

    it 'returns string' do
      expect(Pathname2.pwd).to be_a(String)
    end

    it 'returns current directory' do
      expect(Pathname2.pwd).to eq(pwd)
    end
  end

  describe 'String#to_path' do
    let(:string) { '/usr/local/bin' }

    it 'responds to to_path' do
      expect(string).to respond_to(:to_path)
    end

    it 'returns Pathname2 instance' do
      expect(string.to_path).to be_a(Pathname2)
    end

    it 'preserves path content' do
      expect(string.to_path).to eq(string)
    end
  end
end
