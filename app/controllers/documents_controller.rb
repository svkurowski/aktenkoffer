class DocumentsController < ApplicationController
  include ActiveStorage::SetCurrent

  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = documents_for(params)
    @documents = @documents.includes(:recipient, :sender)
                           .paginate(page: params[:page])
                           .order_by_acted_at
  end

  def show
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    @document = Document.new(document_params)

    unless @document.save
      render :new
      return
    end

    redirect_to documents_url, notice: 'Document was successfully created.'
  end

  def update
    # The original_file attachment is readonly. We enforce this in the controller
    # because model validations do not support ActiveStorage attachments.
    unless @document.update(document_params.except(:original_file))
      render :edit
      return
    end

    redirect_to @document, notice: 'Document was successfully updated.'
  end

  def destroy
    @document.destroy

    redirect_to documents_url, notice: 'Document was successfully deleted.'
  end

  private

    def documents_for(params)
      return Document.where(id: params[:new_documents]) if params[:new_documents].present?

      Search::DocumentSearch.perform(params[:query])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      result = params.require(:document)
                     .permit(:original_file, :title, :sender_id, :recipient_id, :sent_at, :received_at, :tag_names)
      result[:tag_names] = result[:tag_names]&.split(',')
      result
    end

    def query_params
      params.permit(:query, :new_documents)
    end
end
