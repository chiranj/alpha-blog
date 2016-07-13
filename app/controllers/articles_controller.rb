class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :updatte, :destroy]
  
  def index
    @article = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
  
    @article = Article.new
    
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = " Article was Successfully Deleted"
    redirect_to articles_path 
  end
  
  
  def edit
  end
  
  def create
    #debugger
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was Succesfully Created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Artical Succesfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  
  end
  
  def show
  end
  
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description)
  
  end
  
  def require_same_user
    if current_user != @article.user 
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end
  
  
end