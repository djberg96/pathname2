require 'spec_helper'

RSpec.describe Pathname2, '#realpath' do
  let(:pwd) { Dir.pwd }
  let(:test_file) { 'realpath_test.txt' }
  let(:link_file) { 'realpath_symlink.txt' }
  let(:link_file2) { 'realpath_symlink2.txt' }

  after do
    File.delete(link_file2) if File.exist?(link_file2)
    File.delete(link_file) if File.exist?(link_file)
    File.delete(test_file) if File.exist?(test_file)
  end

  it 'has realpath method' do
    expect(Pathname2.new('/usr/local/bin')).to respond_to(:realpath)
  end

  it 'returns current directory for "."' do
    expect(Pathname2.new('.').realpath).to eq(pwd)
  end

  it 'returns Pathname2 instance' do
    FileUtils.touch(test_file)
    File.symlink(test_file, link_file)
    expect(Pathname2.new(link_file).realpath).to be_a(Pathname2)
  end

  it 'resolves simple symlinks correctly' do
    FileUtils.touch(test_file)
    File.symlink(test_file, link_file)
    expect(Pathname2.new(link_file)).not_to eq(Pathname2.new(link_file).realpath)
  end

  it 'raises error for non-existent paths' do
    expect { Pathname2.new('../bogus').realpath }.to raise_error(Errno::ENOENT)
  end

  it 'resolves nested symlinks correctly' do
    FileUtils.touch(test_file)
    File.symlink(test_file, link_file)
    File.symlink(link_file, link_file2)

    expect(Pathname2.new(link_file)).not_to eq(Pathname2.new(link_file2).realpath)
    expect(Pathname2.new(link_file).realpath).to eq(Pathname2.new(link_file2).realpath)
  end
end
