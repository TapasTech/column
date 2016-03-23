# frozen_string_literal: true
class DatasetService
  def self.search(params)
    Dataset.where('title LIKE ?', "%#{params[:query]}%")
  end
end
