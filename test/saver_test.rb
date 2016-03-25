require './test/test_helper'

require './lib/saver'

describe Saver do
  it 'should write the given object to the save file' do
    test_io = StringIO.new

    Saver.save_all({ test: 'testen' }, test_io)
    test_io.string.must_equal "---\n:test: testen\n"
  end
end
