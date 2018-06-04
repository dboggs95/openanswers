class SearchController < ApplicationController
  before_action :locked_user, only: [:results]
  
  def index
    q = params[:query]
    if params[:page]
      pg = params[:page]
      pg_str = "&page=#{pg}"
    else
      pg_str = ""
    end
    redirect_to search_results_path + "?utf8=✓&query=" + "#{q}" + pg_str
  end

  def results
    q = params[:query]
    @q = q
    if params[:page]
      pg = params[:page]
    else
      pg = 1
    end
    @pg = pg.to_i
    per = 25
    unless q.blank?
      @res = Question.search do
        #NEVER put an instance variable here!!!
        #Id est, @q. It will return the whole table!
        fulltext q do
          fields(:title => 5.0, :body => 1.0)
        end
        paginate :page => pg, :per_page => per
      end
      if @res.total < per
        @per = @res.total
      else
        @per = per
      end
    end
  end
  private
	def locked_user
	  if signed_in?
      if current_user.locked
        redirect_to users_locked_path(:id => current_user.id)
      end
    end
    end
end