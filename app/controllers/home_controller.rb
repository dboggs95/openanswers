class HomeController < ApplicationController
  before_action :locked_user
  def index
    questions = Question.all
    if questions.size < 15
      @questions = questions.reverse
    else
      @questions = questions[-15..-1].reverse
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  def locked_user
    if signed_in?
      if current_user.locked
        redirect_to users_locked_path(:id => current_user.id)
      end
    end
  end
end
