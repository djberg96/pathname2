require 'spec_helper'

RSpec.describe Pathname2, 'URL path conversion' do
  let(:url_path) { Pathname2.new('file:///foo%20bar/baz') }

  it 'converts URL-encoded paths' do
    expect(url_path).to eq('/foo bar/baz')
  end
end
