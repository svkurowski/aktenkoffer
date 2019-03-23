module API
  class DocumentsController < API::BaseController
    def create
      document = Document.new(document_params)

      unless document.save
        render json: document.errors, status: :unprocessable_entity
        return
      end

      render json: document, status: :created, location: document
    end

    private

      def document_params
        params.require(:document).permit(:original_file)
      end
  end
end
