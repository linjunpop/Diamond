desc "Run the Tests"
task :test do
  unless system('xctool -workspace Diamond.xcworkspace -scheme Diamond test -test-sdk iphonesimulator')
    exit(-1)
  end
end

task :default => 'test'

