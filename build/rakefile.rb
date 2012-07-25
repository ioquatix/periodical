
# Automatic Gem Build Script v3.0

require 'fileutils'
require 'rubygems'

MasterGemspec = "master.rb"

GEM = ENV['GEM'] || "gem"

desc 'Build a gemspec file'
task :build_gemspec do
  $spec = Gem::Specification.load(MasterGemspec)
  
  $versioned_gem = "#{$spec.name}-#{$spec.version}.gem"
  $versioned_gemspec = "#{$spec.name}-#{$spec.version}.gemspec"
  $base_gemspec = "#{$spec.name}.gemspec"
  
  puts "Building #{$versioned_gemspec}..."
  
  File.open($versioned_gemspec, "w") do |f|
    f.write($spec.to_ruby)
  end
  
  puts "Copying file to ../#{$base_gemspec}"
  FileUtils.cp($versioned_gemspec, "../#{$base_gemspec}")
end

task :build_gem => [:build_gemspec] do
  Dir.chdir("../") do
    system("#{GEM} build #{$base_gemspec}")
  end
end

task :install_gem => [:build_gem] do
  Dir.chdir("../") do
    system("#{GEM} install --local #{$versioned_gem}")
  end
end
