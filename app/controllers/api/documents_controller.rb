module API
  class DocumentsController < API::BaseController
    def create
      documents = document_batch_params

      begin
        Document.transaction do
          @new_documents = Document.create!(documents)
        end
      rescue ActiveRecord::RecordInvalid
        render json: @new_documents, status: :unprocessable_entity
        return
      end

      render json: @new_documents, status: :created, location: location_for(@new_documents)
    end

    private

      def document_batch_params
        params[:documents][:original_files].map { |file| { original_file: file } }
      end

      def location_for(new_documents)
        return new_documents.first if new_documents.one?

        documents_path(new_documents: new_documents.map(&:id))
      end
  end
end
