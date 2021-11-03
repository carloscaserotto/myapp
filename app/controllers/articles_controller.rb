class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    
    def show
        #byebug
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article = Article.new
    end
    def edit
    end

    def create
        byebug
        #render plain: params[:article]
        #render plain: params[:article][:title]
        @article = Article.new(article_params)
        @article.user = current_user
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
        if @article.update(article_params)
            flash[:notice] = "Article updated"
            redirect_to @article
        else
            render 'edit'
        end

    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_article 
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description, category_ids: [] )
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end


end
