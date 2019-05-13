# Uploaded Transactions Manager

This tool allows real estate agents to upload and manager their past real estate transactions.

My notes are prefixed with **EH:**

## Tech
* Ruby 2.4.1
* Rails 5.1.4
* SQLite

## Setup
* Have the tech installed in the dev env
* Clone the repo locally
* Run `bundle install`
* Run `db:setup`
* Run `rails server`
* Navigate to `localhost:3000`

## Assignments (choose at least 2)

**EH:** I chose to work on options 1, 3, 4, and 8 to demonstrate a mix of backend and frontend skills.

1. Build a bulk transaction uploader - allow agents to upload a CSV where each row represents a new transaction
  * Each column should represent the columns in the model
  * De-dupe on `address`, `zip` and `selling_date`

      **EH:** I created a simple view for file upload and a service object (`UploadedTransactionBulkUploader`) to handle the upload logic. The service object performs a little validation before attempting to bulk write the records into the database. If an existing record matches on address, zip, and selling_date, I chose to update the record with the new data, though it might also make sense to discard the change. Should any record fail to save, the entire transaction will fail as well.

      With more time, I'd do a couple more things. On the file upload form, I'd implement some JavaScript to show the chosen file name in the file input. Also, if we had a job queue set up, I would actually defer the bulk upload of the CSV file to the queue to avoid processing a potentially large file on thread. There would also need to be some dashboard or notification system alerting the agent to changes in the status of their upload, perhaps requiring a new class to track the submission and completion/failure of a particular upload.

2. Add model and client-side validation and add styling to the form.
3. Paginate the transactions list on the agent profile page

   **EH:** The kaminari gem is used for pagination and a simple Bootstrap element controls page navigation. The page control can probably be extracted into a generic partial for reuse. Query params keep track of the current page.

4. Sort the transactions list on the agent profile page by selling_date but sort transactions where the `property_type` is "land" or "mobile_home" at the bottom of the list

   **EH:** I extracted the query logic of Agent#all_transactions to a query object, `UploadedTransaction::OrderedQuery`. I could have just added a scope to `Agent` or `UploadedTransaction`, but since this logic is for display only, I wanted to separate this concern from the models.

5. Build filtering and sorting controls to the transaction list on the agent profile
6. Optimize / speed up the `UploadedTransaction` queries - assume there are 10 million rows in that table
7. Allow the agent to select which side of the transaction they represented (seller, buyer or both)
8. Increase test coverage and add front-end testing

   **EH:** I added unit tests for `UploadedTransactionBulkUploader` and `UploadedTransaction::BulkUploadsController`.
