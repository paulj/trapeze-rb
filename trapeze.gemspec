# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{trapeze}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Jones"]
  s.date = %q{2009-09-24}
  s.default_executable = %q{trapezerb}
  s.description = %q{AMQP Trapeze Connector allows you to expose your web applications to the web via an AMQP HTTP gateway.}
  s.email = %q{pauljones23@gmail.com}
  s.executables = ["trapezerb"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["Rakefile", "README.rdoc", "VERSION.yml", "bin/trapezerb", "lib/rack", "lib/rack/handler", "lib/rack/handler/trapeze.rb", "lib/trapeze", "lib/trapeze/amqp_connector.rb", "lib/trapeze/rack_adapter.rb", "lib/trapeze/runner.rb", "lib/trapeze/thin_backend.rb", "lib/trapeze.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/paulj/trapeze-rb/}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{AMQP Trapeze Connector}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
