class ArticlesController < ApplicationController
    def show
        #byebug
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end
    def edit
        @article = Article.find(params[:id])
    end

    def create
        #byebug
        #render plain: params[:article]
        #render plain: params[:article][:title]
        @article = Article.new(params.require(:article).permit(:title, :description))
        #render plain:@article.inspect
        if @article.save
            flash[:notice] = "Article successfully created"
            redirect_to article_path(@article) #voy a la pagina Show article
        else
            render 'new'
            
        end
        #redirect_to articles_path #voy a la pagina Index article
    end

    def update
        #byebug
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article updated"
            redirect_to @article
        else
            render 'edit'
        end

    end

    

    


end
