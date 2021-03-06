require File.expand_path('../test_helper', __FILE__)

class FileUriTest < Minitest::Test
  def test_file_uri_has_correct_components
    path = data_fixture_path('all_of_ref_data.json')
    uri = URI.parse("file://#{path}#name")
    assert_equal('file', uri.scheme)
    assert_equal('', uri.host)
    assert_equal(path, uri.path)
    assert_equal(nil, uri.query)
    assert_equal('name', uri.fragment)
  end

  def test_file_uri_loads_real_file
    path = data_fixture_path('all_of_ref_data.json')
    assert_equal(%Q({\n  "name" : "john"\n}\n), open("file://#{path}").read)
  end

  def test_file_uri_fails_for_invalid_file
    path = File.absolute_path(File.dirname(__FILE__) + '/this_should_not_exist')
    assert_raises(Errno::ENOENT) do
      open("file://#{path}").read
    end
  end
end
