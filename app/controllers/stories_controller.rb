class StoriesController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create, :upvote, :downvote]
    
    def index
        @stories = Story.all.order(id: :desc).page(params[:page]).per(10)
    end
    
    def new
        @story = Story.new
    end
    
    def create
        @story = Story.new(story_params)
        @story.user = current_user
        if @story.save
            redirect_to @story
        else
            flash[:danger] = @story.errors.full_messages.to_sentence
            render :new
        end
        
    end
    
    def show
        @story = Story.find(params[:id])
    end
    
    def upvote
        @story = Story.find(params[:id])
        @story.upvote_by(current_user)
        redirect_to :back
    end
    
    def downvote
        @story = Story.find(params[:id])
        @story.downvote_by(current_user)
        redirect_to :back
    end
    
    def search
        if params[:search].blank?
            @stories = Story.all
        else
            @stories = Story.search(params)
        end
        
        
    end
    
    def story_params
        params.require(:story).permit(:body, :category_id)
    end
end