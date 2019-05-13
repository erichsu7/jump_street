class UploadedTransactions::BulkUploadsController < ApplicationController

  def new
  end

  def create
    file = params[:file]
    begin
      ::UploadedTransactionBulkUploader.new(file).call!
      flash[:notice] = "Upload succeeded"
    rescue ArgumentError => e
      flash[:alert] = e.message
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = e.record.errors.full_messages.to_sentence
    end
    redirect_to(new_uploaded_transactions_bulk_upload_path)
  end

end
