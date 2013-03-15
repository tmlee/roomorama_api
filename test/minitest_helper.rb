require 'minitest/autorun'
require 'fakeweb'

FakeWeb.allow_net_connect = false

def fixture_file(filename, options={})
  return '' if filename == ''

  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  fixture   = File.read(file_path)

  case File.extname(file_path)
    when '.json'
      options[:parse] ? JSON.parse(fixture) : fixture
    else
      fixture
  end
end


def stub_get(url, filename, options={})
  opts = {
    :body => error_or_standard_body(filename, options)
  }.merge(options)
  FakeWeb.register_uri(:get, url, opts)
end

def stub_post(url, filename, options={})
  opts = {
    :body => error_or_standard_body(filename, options),
  }.merge(options)
  FakeWeb.register_uri(:post, url, opts)
end

def stub_delete(url, filename, options={})
  opts = {
    :body => error_or_standard_body(filename, options),
  }.merge(options)
  FakeWeb.register_uri(:delete, url, opts)
end

def stub_put(url, filename, options={})
  opts = {
    :body => error_or_standard_body(filename, options),
  }.merge(options)
  FakeWeb.register_uri(:put, url, opts)
end


def error_or_standard_body(filename, options)
  error_options = options.delete(:error)
  body = fixture_file(error_options ? 'error_template.json' : filename)
  body = body.gsub(/%error_code%/, error_options[:code])
             .gsub(/%error_type%/, error_options[:type])
             .gsub(/%error_message%/, error_options[:message]) if error_options
  body
end