# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{snooze_force}
  s.version = "1.0.0.20110707132152"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["markbates"]
  s.date = %q{2011-07-07}
  s.description = %q{snooze_force was developed by: markbates}
  s.email = %q{}
  s.extra_rdoc_files = ["LICENSE"]
  s.files = ["lib/snooze_force/base.rb", "lib/snooze_force/client.rb", "lib/snooze_force/errors.rb", "lib/snooze_force/user.rb", "lib/snooze_force.rb", "LICENSE"]
  s.homepage = %q{}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{snooze_force}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
  end
end
