class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_link_and_verify_ownership, only: [:edit, :update, :destroy]

  # GET /links
  def index
    @links = Link.all
  end

  # GET /links/1
  def show
    @link = Link.find(params[:id])
  end

  # GET /links/new
  def new
    @link = current_user.links.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to @link, notice: 'Link was successfully created.' 
    else
      render :new
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  private

    def find_link_and_verify_ownership
      @link = Link.find(params[:id])
      if @link.user != current_user
        redirect_to @link, notice: "You aren't allowed to perform this action."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:user_id, :url, :title)
    end
end
