require 'spec_helper'

RSpec.describe Pathname2, '#unc?' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }

  it 'raises NotImplementedError on Unix systems' do
    expect { abs_path.unc? }.to raise_error(NotImplementedError)
  end
end
