require 'minitest/autorun'

require './test/test_helper'

require './lib/saver'

describe Saver do
  it "should write the given object to the save file" do
    testIO = StringIO.new

    Saver.save_all({ test: 'testen'}, testIO)
    testIO.string.must_equal "---\n:test: testen\n"
  end
end
