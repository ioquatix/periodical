
Dir.chdir("../") do
	require './lib/periodical/version'

	Gem::Specification.new do |s|
		s.name = "periodical"
		s.version = Periodical::VERSION::STRING
		s.author = "Samuel Williams"
		s.email = "samuel.williams@oriontransfer.co.nz"
		s.homepage = "http://www.oriontransfer.co.nz/"
		s.platform = Gem::Platform::RUBY
		s.summary = "Periodical is a simple framework for working with durations and periods."
		s.files = FileList["{bin,lib,test}/**/*"] + ["README.md"]

		s.has_rdoc = "yard"
	end
end
