# spec/support/vcr_setup.rb
VCR.configure do |c|
  c.hook_into :excon
  c.cassette_library_dir = 'spec/vcr'
end
