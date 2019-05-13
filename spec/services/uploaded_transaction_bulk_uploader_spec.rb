describe UploadedTransactionBulkUploader do
  let(:test_file_path) { File.join(Rails.root, "spec/fixtures/files/uploaded_transaction_data.csv") }
  let(:test_file_num_lines) { File.foreach(test_file_path).count }

  describe "#call" do
    it "should add new UploadedTransactions" do
      UploadedTransactionBulkUploader.new(test_file_path).call!
      expect(UploadedTransaction.all.count).to eq(test_file_num_lines - 1)
    end

    it "should dedupe UploadedTransactions" do
      UploadedTransactionBulkUploader.new(test_file_path).call!
      UploadedTransactionBulkUploader.new(test_file_path).call!
      expect(UploadedTransaction.all.count).to eq(test_file_num_lines - 1)
    end

    it "should raise ArgumentError if no path is given" do
      expect { UploadedTransactionBulkUploader.new(nil).call! }.to raise_error(ArgumentError)
      expect { UploadedTransactionBulkUploader.new("").call! }.to raise_error(ArgumentError)
    end

    it "should raise ArgumentError if file is not .csv" do
      expect { UploadedTransactionBulkUploader.new("bad.txt").call! }.to raise_error(ArgumentError)
    end
  end

end
