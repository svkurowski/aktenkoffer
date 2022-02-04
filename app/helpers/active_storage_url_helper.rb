module ActiveStorageUrlHelper
  def object_url_for(blob)
    if browser.safari?
      ActiveStorage::Current.set(host: request.base_url) do
        blob.url
      end
    else
      url_for blob
    end
  end
end
