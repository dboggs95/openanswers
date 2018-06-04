class CommentsController < ApplicationController
    before_action :set_question, only: [:create, :update, :destroy]
    before_action :set_comment, only: [:update, :destroy]
    before_action :signed_in_user, only: [:create]
    before_action :admin_or_correct_user, only: [:update, :destroy]

    def create
        @comment = @question.comments.create(comment_params)
        if !@comment.nil?
            flash[:success] = "Comment created successfully!"
            redirect_to @question
        else 
            flash[:alert] = "Comment creation failed!"
            redirect_to @question 
        end
    end

    def update
        if @comment.update_attributes(comment_params)
            flash[:success] = "Comment updated."
            redirect_to @question
        else
            render @question
        end
    end
    
    def destroy
        @comment.destroy
        flash[:success] = "Comment successfully destroyed."
        redirect_to @question
    end

private
    def set_question
        @question = Question.find(params[:question_id])
    end
    def set_comment
        @comment = @question.comments.find(params[:id])
    end
    def comment_params
	    params.require(:comment).permit(:body, :user_id, :answer_id)
    end
    def signed_in_user
        if !signed_in?
            flash[:failure] = "You must sign in first."
            redirect_to '/signin'
        end
    end
    def admin_or_correct_user
        redirect_to home_index_path unless (@comment.user_id == current_user.id || current_user.admin)
    end
end
