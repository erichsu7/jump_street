class UploadedTransaction < ApplicationRecord
  validates_presence_of :address, :city, :state, :zip
  validates_inclusion_of :property_type, in: %w(single_family_home multi_family_home), allow_nil: true

  belongs_to :listing_agent, required: false, class_name: "Agent"
  belongs_to :selling_agent, required: false, class_name: "Agent"

  scope :single_family_homes, -> { where(property_type: "single_family_home") }
  scope :sold, -> { where(status: "sold") }

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end
end
