describe UploadedTransactions::BulkUploadsController, type: :controller do

  describe "#new" do
    it "should return 200" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  # not testing error handling because the UploadedTransactionsBulkUploader
  # unit tests handle that
  describe "#create" do
    let(:test_file) { fixture_file_upload("files/uploaded_transaction_data.csv", "text/csv") }
    it "should return 302" do
      post :create, params: { file: test_file }
      expect(response).to have_http_status(302)
    end
  end

end
