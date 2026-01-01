require 'spec_helper'

RSpec.describe Pathname2, '#+' do
  let(:abs_path) { Pathname2.new("C:\\foo\\bar") }
  let(:rel_path) { Pathname2.new("foo\\bar\\baz") }

  def assert_pathname_plus(a, b, c)
    a = Pathname2.new(a)
    b = Pathname2.new(b)
    c = Pathname2.new(c)
    expect(b + c).to eq(a)
  end

  describe 'appending to absolute paths' do
    it 'appends correctly' do
      assert_pathname_plus("C:\\a\\b", "C:\\a", "b")
      assert_pathname_plus("C:\\b", "a", "C:\\b")
      assert_pathname_plus("a\\b", "a", "b")
      assert_pathname_plus("C:\\b", "C:\\a", "..\\b")
      assert_pathname_plus("C:\\a\\b", "C:\\a\\.", "\\b")
      assert_pathname_plus("C:\\a\\b.txt", "C:\\a", "b.txt")
    end
  end

  describe 'appending to UNC paths' do
    it 'appends correctly' do
      assert_pathname_plus("\\\\foo\\bar", "\\\\foo", "bar")
      assert_pathname_plus("\\\\foo", "\\\\", "foo")
      assert_pathname_plus("\\\\", "\\\\", "")
      assert_pathname_plus("\\\\foo\\baz", "\\\\foo\\bar", "\\..\\baz")
      assert_pathname_plus("\\\\", "\\\\", "..\\..\\..\\..")
    end
  end

  describe 'appending plain strings' do
    it 'works as expected' do
      expect(abs_path + 'baz').to eq('C:\foo\bar\baz')
      expect(abs_path).to eq('C:\foo\bar')
    end
  end

  describe 'appending absolute path to relative' do
    it 'results in the absolute path' do
      assert_pathname_plus('C:\foo\bar', rel_path, abs_path)
    end
  end

  describe 'non-destructive behavior' do
    it 'does not modify receiver or argument' do
      result = abs_path + rel_path
      expect(result).to eq('C:\foo\bar\foo\bar\baz')
      expect(abs_path).to eq('C:\foo\bar')
      expect(rel_path).to eq('foo\bar\baz')
    end
  end
end
