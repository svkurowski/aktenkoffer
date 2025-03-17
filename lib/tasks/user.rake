namespace :user do
  desc 'Create a new user with the given credentials'
  task :create, [:username, :password] => :environment do |_, args|
    params = args.to_hash.slice(:username, :password)
    User.create!(params)
    puts "Successfully created new user with username #{params[:username]}..."
  end
end
