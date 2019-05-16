class UploadedTransactionsController < ApplicationController
  def new
    @agent = Agent.find(params[:agent_id])
    @uploaded_transaction = @agent.uploaded_lister_transactions.new
  end

  def create
    @agent = Agent.find(params[:agent_id])
    uploaded_transaction = nil
    if params[:transaction_type] == "lister"
      uploaded_transaction = @agent.uploaded_lister_transactions.create(uploaded_transaction_params)
    elsif params[:transaction_type] == "seller"
      uploaded_transaction = @agent.uploaded_seller_transactions.create(uploaded_transaction_params)
    elsif params[:transaction_type] == "both"
      uploaded_transaction = @agent.uploaded_lister_transactions
                                  .create(uploaded_transaction_params.merge(selling_agent_id: agent.id))
    end

    if uploaded_transaction.present? && uploaded_transaction.save
      redirect_to agent_path(@agent), notice: "Transaction saved!"
    else
      @uploaded_transaction = @agent.uploaded_lister_transactions.new
      render "new", alert: "Error could not be saved"
    end
  end

  private

  def uploaded_transaction_params
    params.require(:uploaded_transaction).permit(:address, :city, :state, :zip, :listing_agent, :listing_price, :listing_date, :selling_price, :selling_agent, :selling_date, :status, :property_type)
  end
end
