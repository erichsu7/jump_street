require "csv"

class UploadedTransactionBulkUploader

  def initialize(path)
    @path = path
  end

  # raises an exception on failure. catch it in the controller.
  def call!
    validate!
    # upload in transaction: if any row is invalid, fail the whole job
    ActiveRecord::Base.transaction do
      # read line by line to save on memory when reading large files
      CSV.foreach(path, headers: true) do |row|
        # dedupe on address, zip, selling_date
        transaction = UploadedTransaction.where(address: row["address"],
                                                zip: row["zip"],
                                                selling_date: row["selling_date"])
                                         .first_or_initialize
        # choosing to update existing records. we may just want to discard
        # a transaction if it already exists and return an exception.
        transaction.update!(row.to_hash)
      end
    end

    true
  end

  private

  attr_reader :path

  def validate!
    raise ArgumentError.new("No file selected") if path.nil? || path.length == 0
    raise ArgumentError.new("Invalid file type") unless File.extname(path) == ".csv"
  end

end
