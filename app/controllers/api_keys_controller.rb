class APIKeysController < ApplicationController
  before_action :set_api_key, only: [:show, :edit, :update, :destroy]

  # GET /api_keys
  def index
    @api_keys = APIKey.all
  end

  # GET /api_keys/1
  def show
  end

  # GET /api_keys/new
  def new
    @api_key = APIKey.new
  end

  # GET /api_keys/1/edit
  def edit
  end

  # POST /api_keys
  def create
    @secret = SecureRandom.hex(APIKey::SECRET_LENGTH / 2)
    @api_key = APIKey.new(api_key_params.merge(secret: @secret))

    if @api_key.save
      flash.now[:notice] = 'API key was successfully created.'
      render :create
    else
      render :new
    end
  end

  # PATCH/PUT /api_keys/1
  def update
    if @api_key.update(api_key_params)
      redirect_to @api_key, notice: 'API key was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /api_keys/1
  def destroy
    @api_key.destroy
    redirect_to api_keys_url, notice: 'API key was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_key
      @api_key = APIKey.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_key_params
      params.require(:api_key).permit(:description)
    end
end
