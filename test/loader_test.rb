require './test/test_helper'

require './lib/loader'

describe Loader do
  it "should read from the given file" do
    testIO = StringIO.new
    testIO << "---\n:test: testen\n"
    testIO.rewind
    Loader.load_all(testIO).must_equal test: 'testen'
  end
end
