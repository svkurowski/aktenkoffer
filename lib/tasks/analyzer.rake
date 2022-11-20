namespace :analyzer do
  desc 'Runs analzers for entities as necessary. Can be used for backfilling data after system upgrades.'
  task backfill: :environment do
    total_count = 0
    Document.needs_original_fily_analysis.find_in_batches do |batch|
      batch.each(&:analyze_original_file_later)
      total_count += batch.size
    end
    puts "Success! Enqueued analysis jobs for #{total_count} documents."
  end
end
