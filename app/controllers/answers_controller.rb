class AnswersController < ApplicationController
    before_action :set_question, only: [:create, :update, :destroy]
    before_action :set_answer, only: [:update, :destroy]
    before_action :signed_in_user, only: [:create]
    before_action :admin_or_correct_user, only: [:update, :destroy]

    def create
        @answer = @question.answers.create(answer_params)
        if !@answer.nil?
            flash[:success] = "Answer created successfully!"
            redirect_to @question
        else 
            flash[:alert] = "Answer creation failed!"
            redirect_to @question 
        end
    end

    def update
        if @answer.update_attributes(answer_params)
            flash[:success] = "Answer updated."
            redirect_to @question
        else
            render @question
        end
    end
    
    def destroy
        @answer.destroy
        flash[:success] = "Answer successfully destroyed."
        redirect_to @question
    end

private
    def set_question
        @question = Question.find(params[:question_id])
    end
    def set_answer
        @answer = @question.answers.find(params[:id])
    end
    def answer_params
	    params.require(:answer).permit(:body, :user_id, :code, :license)
    end
    def signed_in_user
        if !signed_in?
            flash[:failure] = "You must sign in first."
            redirect_to '/signin'
        end
    end
    def admin_or_correct_user
        redirect_to home_index_path unless (@answer.user_id == current_user.id || current_user.admin)
    end   
end
