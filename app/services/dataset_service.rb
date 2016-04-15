# frozen_string_literal: true
class DatasetService
  def self.search(params)
    # Dataset.where('title LIKE ?', "%#{params[:query]}%").where()
    query = Dataset.all.page(params[:page]).per(params[:per])
    query = query.where('title LIKE ?', "%#{params[:query]}%") if params[:query].present?
    query = query.where('tags @> ARRAY[?]::varchar[]', params[:tags]) if params[:tags].present?
    query
  end
end
