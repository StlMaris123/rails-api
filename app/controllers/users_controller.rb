class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    page_number = params.dig(:page, :number) || 1
    page_size = params.dig(:page, :size) || User.default_per_page
    @users = User.page(page_number).per(page_size)
    if stale?(@users)
      render json: @users, include: [], meta: pagination_meta(@users)
    end
  end

  # GET /users/1
  def show
    included_rels = params[:include] || []
    if stale?(@user)
    render json: @user, include: included_rels
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {})
    end
end
