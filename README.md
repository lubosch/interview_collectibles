# Solution

1. create cards migration
2. create graded cards migration
3. Insert 100_000 cards with single db insert query
4. Insert 200_000 cards using bulk card select and single db insert query
5. Create unique index concurrently on card_id, grade, qualifier that assures that NULL values are not distinct.
This is new feature in postgres 15. Concurrent index creation speeds up process.
6. Add tracking column with default false value. Default value is added immediately in postgres 15 and is not
added to each row physically.
7. Add sidekiq
8. Create CreateGradedCardJob job that adds graded card with grade: nil, qualifier: nil, card: Card.last.
Handle that there are no duplicates using `validates :card_id, uniqueness: { scope: %i[grade qualifier] }`
on RoR level and handle duplicates on DB level using index from step 5. Add error handling for duplicates.
I chose optimistic lock because we can just ignore this error.
9. Add import_graded_cards_with_sidekiq rake task that creates 200 jobs
10. Create import_graded_cards_with_threads rake task that creates 100 threads and each thread is
inserting the same data. Handle duplicate errors and ensure that connection_pool is released afterward.
Wait until all threads finish. I chose optimistic lock again because we can just ignore this error.
11. Create dockerfile
12. Create compose.yml for docker compose. Add redis, postgres, app, sidekiq services and configure them all

Files to look at:
- app/jobs/create_graded_card_job.rb
- app/models/graded_card.rb
- app/services/create_graded_card.rb
- all db migrations
- lib/tasks/graded_cards.rake
- Dockerfile
- compose.yaml

## How to run
```
docker-compose build
docker-compose run -it app rails db:migrate
docker-compose up
docker-compose run -it app rake import_graded_cards_with_sidekiq 
docker-compose run -it app rake import_graded_cards_with_threads 
```
