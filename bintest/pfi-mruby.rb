require 'open3'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/pfi-mruby")

assert('hello') do
  output, status = Open3.capture2(BIN_PATH)

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "(P)ath(f)inder (I)nterface"
end

assert('version') do
  output, status = Open3.capture2(BIN_PATH, "version")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "v0.0.1"
end
