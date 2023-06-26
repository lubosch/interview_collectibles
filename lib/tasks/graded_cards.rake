task :import_graded_cards_with_threads => :environment do
  threads = 100.times.map do
    Thread.new do
      CreateGradedCard.call
    ensure
      ActiveRecord::Base.connection_pool.release_connection
    end
  end
  threads.each(&:join)
end

task :import_graded_cards_with_sidekiq => :environment do
  200.times { CreateGradedCardJob.perform_later }
end
