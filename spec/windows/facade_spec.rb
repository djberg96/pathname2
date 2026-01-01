require 'spec_helper'

RSpec.describe Pathname2, 'facade methods' do
  let(:path) { Pathname2.new("C:/Program Files") }

  describe 'File methods' do
    it 'responds to all File methods' do
      File.methods(false).each { |m| expect(path).to respond_to(m.to_sym) }
    end
  end

  describe 'Dir methods' do
    it 'responds to all Dir methods' do
      Dir.methods(false).each { |m| expect(path).to respond_to(m.to_sym) }
    end
  end

  describe 'FileUtils methods' do
    it 'responds to FileUtils methods' do
      methods = FileUtils.public_instance_methods
      methods -= File.methods(false)
      methods -= Dir.methods(false)
      methods.delete_if { |m| m =~ /stream|^ln|identical\?|mode_to_s|^sh|ruby|safe_ln|split_all/i }

      methods.each { |method| expect(path).to respond_to(method.to_sym) }
    end
  end

  describe 'Find method' do
    it 'responds to find' do
      expect(path).to respond_to(:find)
    end

    it 'yields Pathname2 instances' do
      Pathname2.new(Dir.pwd).find do |f|
        Find.prune if f.match("git")
        expect(f).to be_a(Pathname2)
        break
      end
    end
  end

  describe 'IO methods' do
    it 'responds to custom IO methods' do
      expect(path).to respond_to(:foreach)
      expect(path).to respond_to(:read)
      expect(path).to respond_to(:readlines)
      expect(path).to respond_to(:sysopen)
    end
  end

  describe 'exist? method' do
    it 'works as expected' do
      expect(path).to respond_to(:exist?)
      expect(Pathname2.new("C:\\").exist?).to be true
      expect(Pathname2.new("X:\\foo\\bar\\baz").exist?).to be false
    end
  end
end
