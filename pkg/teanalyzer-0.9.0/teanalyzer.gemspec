# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "teanalyzer"
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jorg Jenni"]
  s.date = "2012-11-06"
  s.description = "An analyzer for keyboard typing efforts"
  s.email = "jorg.jenni@jennius.co.uk"
  s.extra_rdoc_files = ["README", "lib/core/finger_parameters.rb", "lib/core/hand_parameters.rb", "lib/core/hands_parameters.rb", "lib/core/key.rb", "lib/core/keyboard.rb", "lib/core/rows_parameters.rb", "lib/core/triad.rb", "lib/core/tuple.rb", "lib/keyboards/uk-keyboard", "lib/parameters.rb", "lib/teanalyzer.rb"]
  s.files = ["Gemfile", "Gemfile.lock", "HOWTO", "Manifest", "README", "Rakefile", "aliceinwonderland.txt", "lib/core/finger_parameters.rb", "lib/core/hand_parameters.rb", "lib/core/hands_parameters.rb", "lib/core/key.rb", "lib/core/keyboard.rb", "lib/core/rows_parameters.rb", "lib/core/triad.rb", "lib/core/tuple.rb", "lib/keyboards/uk-keyboard", "lib/parameters.rb", "lib/teanalyzer.rb", "sim.py", "spec/hand_parameters_spec.rb", "spec/key_spec.rb", "spec/keyboard_spec.rb", "spec/teanalyzer_spec.rb", "spec/triad_spec.rb", "timing.rb", "teanalyzer.gemspec"]
  s.homepage = "https://github.com/Enceradeira/teanalyzer"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Teanalyzer", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "teanalyzer"
  s.rubygems_version = "1.8.24"
  s.summary = "An analyzer for keyboard typing efforts"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
