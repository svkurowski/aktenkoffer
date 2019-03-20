class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)

    unless @contact.save
      render :new
      return
    end

    redirect_to contacts_url, notice: 'Contact was successfully created.'
  end

  def update
    unless @contact.update(contact_params)
      render :edit
      return
    end

    redirect_to @contact, notice: 'Contact was successfully updated.'
  end

  def destroy
    @contact.destroy

    redirect_to contacts_url, notice: 'Contact was successfully deleted.'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :address)
    end
end
