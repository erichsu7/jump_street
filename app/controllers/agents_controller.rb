class AgentsController < ApplicationController
  def show
    @agent = Agent.find(params[:id])
    @uploaded_transactions =
      UploadedTransaction::OrderedQuery.new.all.listing_or_selling_agent_id(params[:id])
  end

  def random_agent
    redirect_to agent_path(Agent.all.sample)
  end
end
