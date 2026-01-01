require 'spec_helper'

RSpec.describe Pathname2, '#relative_path_from' do
  def assert_relpath(result, dest, base)
    expect(Pathname2.new(dest).relative_path_from(base)).to eq(result)
  end

  def assert_relative_path_error(to, from)
    expect { Pathname2.new(to).relative_path_from(from) }.to raise_error(ArgumentError)
  end

  it 'works between two relative paths' do
    assert_relpath("..\\a", 'a', 'b')
    assert_relpath("..\\a", 'a', 'b/')
    assert_relpath("..\\a", 'a/', 'b')
    assert_relpath("..\\a", 'a/', 'b/')
    assert_relpath("..\\b", "a\\b", "a\\c")
    assert_relpath("..\\a", "..\\a", "..\\b")
    assert_relpath("..\\b\\c", "a\\b\\c", "a\\d")
    assert_relpath("..", "a\\..", "a")
    assert_relpath(".", "a\\..\\b", "b")
    assert_relpath("a", "a", "b\\..")
    assert_relpath("b\\c", "b\\c", "b\\..")
  end

  it 'works between two absolute paths' do
    assert_relpath("..\\a", "c:\\a", "c:\\b")
    assert_relpath("..\\a", "c:\\a", "c:\\b\\")
    assert_relpath("..\\a", "c:\\a\\", "c:\\b")
    assert_relpath("..\\a", "c:\\a\\", "c:\\b\\")
    assert_relpath("c\\d", "c:\\a\\b\\c\\d", "c:\\a\\b")
    assert_relpath("..\\..", "c:\\a\\b", "c:\\a\\b\\c\\d")
    assert_relpath("..\\..\\..\\..\\e", "c:\\e", "c:\\a\\b\\c\\d")
    assert_relpath("..\\a", "c:\\..\\a", "c:\\b")
    assert_relpath(".", "c:\\a\\..\\..\\b", "c:\\b")
  end

  it 'works for . and ..' do
    assert_relpath("a", "a", ".")
    assert_relpath("..", ".", "a")
    assert_relpath(".", ".", ".")
    assert_relpath(".", "..", "..")
    assert_relpath("..", "..", ".")
  end

  it 'is not allowed between relative and absolute paths' do
    assert_relative_path_error("c:\\", ".")
    assert_relative_path_error(".", "c:\\")
    assert_relative_path_error("a", "..")
    assert_relative_path_error(".", "..")
    assert_relative_path_error("C:\\Temp", "D:\\Temp")
    assert_relative_path_error("\\\\Server\\Temp", "D:\\Temp")
  end
end
