namespace :build do
  desc 'Lints Ruby and JavaScript files'
  task lint: :environment do
    sh('rubocop', Rails.root.to_s)
    sh('yarn', 'run', 'eslint', Rails.root.to_s)
  end

  desc 'Performs a release build'
  task release: [:lint] do
    # Relies on dependency tasks
  end
end
