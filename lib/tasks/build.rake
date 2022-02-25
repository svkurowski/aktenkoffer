namespace :build do
  desc 'Lints Ruby and JavaScript files'
  task lint: :environment do
    sh('rubocop', Rails.root.to_s)
    sh('yarn', 'run', 'lint')
  end

  desc 'Performs a release build'
  task release: ['zeitwerk:check', :lint, 'test:system'] do
    # Relies on dependency tasks
  end
end
