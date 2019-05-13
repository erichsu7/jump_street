class UploadedTransaction::OrderedQuery

  def initialize(relation = UploadedTransaction.unscoped)
    @relation = relation.extending(Scopes)
  end

  # by selling_date but sort transactions where the `property_type` is "land"
  # or "mobile_home" at the bottom of the list
  def all
    relation.order("CASE WHEN property_type IN ('land', 'mobile_home') THEN 1 ELSE 0 END, selling_date DESC")
  end

  module Scopes

    def listing_or_selling_agent_id(agent_id)
      where("listing_agent_id = ? OR selling_agent_id = ?", agent_id, agent_id)
    end

  end

  private

  attr_reader :relation

end
