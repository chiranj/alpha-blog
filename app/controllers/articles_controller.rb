class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  
  def index
    @article = Article.all
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
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
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
  
end