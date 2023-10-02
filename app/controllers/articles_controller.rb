class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 6)
  end
  
  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end  

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created succesfully"
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated succesfully"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article was deleted succesfully"
    end
    redirect_to articles_path, status: :see_other
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end