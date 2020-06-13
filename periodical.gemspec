
require_relative "lib/periodical/version"

Gem::Specification.new do |spec|
	spec.name = "periodical"
	spec.version = Periodical::VERSION
	
	spec.summary = "Periodical is a simple framework for working with durations and periods."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.homepage = "https://github.com/ioquatix/periodical"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
	}
	
	spec.files = Dir.glob('{lib}/**/*', File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 2.0"
	
	spec.add_development_dependency "bake-bundler"
	spec.add_development_dependency "bake-modernize"
end
