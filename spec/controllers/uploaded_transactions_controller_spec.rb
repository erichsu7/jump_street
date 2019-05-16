describe UploadedTransactionsController, type: :controller do

  describe "#create" do
    let!(:agent) { Agent.create }
    it "should assign listing_agent_id when passed transaction_type == lister" do
      post :create, params: {
        uploaded_transaction: {
          address: "123 Main St",
          city: "SF",
          state: "CA",
          zip: 94111,
        },
        agent_id: 1,
        transaction_type: "lister"
      }
      expect(UploadedTransaction.last.listing_agent_id).to eq(1)
      expect(UploadedTransaction.last.selling_agent_id).to eq(nil)
    end
    it "should assign selling_agent_id when passed transaction_type == seller" do
      post :create, params: {
        uploaded_transaction: {
          address: "123 Main St",
          city: "SF",
          state: "CA",
          zip: 94111,
        },
        agent_id: 1,
        transaction_type: "seller"
      }
      expect(UploadedTransaction.last.listing_agent_id).to eq(nil)
      expect(UploadedTransaction.last.selling_agent_id).to eq(1)
    end
    it "should assign listing_agent_id and selling_agent_id when passed transaction_type == both" do
      post :create, params: {
        uploaded_transaction: {
          address: "123 Main St",
          city: "SF",
          state: "CA",
          zip: 94111,
        },
        agent_id: 1,
        transaction_type: "both"
      }
      expect(UploadedTransaction.last.listing_agent_id).to eq(1)
      expect(UploadedTransaction.last.selling_agent_id).to eq(1)
    end
  end

end
