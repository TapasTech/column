# frozen_string_literal: true
class CSVUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    File.join(Settings.carrierwave.paths.store,
              "#{model.class.to_s.underscore}/#{mounted_as}/#{model.created_at.to_date}")
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(csv)
  end

  # Add a white list of content-type which are allowed to be uploaded.
  def content_type_whitelist
    %w(text/csv)
  end

  # Override the filename of the uploaded files:
  # The file is meant to be one2one with a file record model
  def filename
    "#{Digest::SHA256.hexdigest(read)}.csv"
  end
end
