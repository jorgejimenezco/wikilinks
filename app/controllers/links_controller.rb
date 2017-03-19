class LinksController < ApplicationController
  def index
      @links = Link.all
  end

  def new
    @link = Link.new
  end

  def show
    @link = Link.find(params[:id])
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      flash[:notice] = 'Link was created successfully'
      redirect_to links_path
    else
      flash[:alert] = ' Failed, Link was not created'
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])

  if @link.update(link_params)
    flash[:notice] = 'Post has been updated successfully'
    redirect_to links_path
  else
    flash[:alert] = 'Failed, Post has not been updated'
    render :edit
  end

  def destroy
    @link = Link.delete(params[:id])
  flash[:notice] = 'Link has been eliminated'
  redirect_to link_path
  end
end


private

  def link_params
    params.require(:link).permit(:title, :description, :url)
  end

  def is_admin?
    unless current_user.admin?
    flash[:alert] = 'You do not have permission to access'
    end
  end
end
