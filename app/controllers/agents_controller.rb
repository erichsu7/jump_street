class AgentsController < ApplicationController

  def show
    @agent = Agent.find(params[:id])
    @page = params[:page]&.to_i || 1
    @uploaded_transactions =
      UploadedTransaction::OrderedQuery.new.all.listing_or_selling_agent_id(params[:id]).page(@page)
  end

  def random_agent
    redirect_to agent_path(Agent.all.sample)
  end
end
