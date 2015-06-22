class WikisController < ApplicationController
  
  def index
    @wikis = Wiki.includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end


  def create
    @wiki = current_user.wikis.build(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki Saved!"
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving your Wiki. Please try again."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating your Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted!."
      redirect_to wikis_path
    else
      flash[:error] = "Error deleting Wiki. Please try again."
      render :show
    end
  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :user)
  end
end




