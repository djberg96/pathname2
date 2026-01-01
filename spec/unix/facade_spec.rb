require 'spec_helper'

RSpec.describe Pathname2, 'facade methods' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }

  describe 'IO methods' do
    it 'responds to foreach' do
      expect(abs_path).to respond_to(:foreach)
    end

    it 'responds to read' do
      expect(abs_path).to respond_to(:read)
    end

    it 'responds to readlines' do
      expect(abs_path).to respond_to(:readlines)
    end

    it 'responds to sysopen' do
      expect(abs_path).to respond_to(:sysopen)
    end
  end

  describe 'File methods' do
    it 'responds to all File methods' do
      File.methods(false).each do |method|
        expect(abs_path).to respond_to(method.to_sym)
      end
    end
  end

  describe 'Dir methods' do
    it 'responds to all Dir methods' do
      Dir.methods(false).each do |method|
        expect(abs_path).to respond_to(method.to_sym)
      end
    end
  end

  describe 'FileUtils methods' do
    it 'responds to FileUtils methods' do
      methods = FileUtils.public_instance_methods
      methods -= File.methods(false)
      methods -= Dir.methods(false)
      methods.delete_if { |m| m.to_s =~ /stream/ }
      methods.delete(:identical?)
      methods.delete(:sh)
      methods.delete(:ruby)
      methods.delete(:safe_ln)
      methods.delete(:split_all)

      methods.each do |method|
        expect(abs_path).to respond_to(method.to_sym)
      end
    end
  end

  describe 'Find methods' do
    it 'responds to find' do
      expect(abs_path).to respond_to(:find)
    end

    it 'yields Pathname2 instances' do
      Pathname2.new(Dir.pwd).find do |f|
        Find.prune if f.match('CVS')
        expect(f).to be_a(Pathname2)
        break
      end
    end
  end
end
