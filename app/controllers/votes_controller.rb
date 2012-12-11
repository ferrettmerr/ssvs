class VotesController < ApplicationController

  before_filter :authenticate_user!
  def vote
    #Testing until I get auth working
    user = current_user
    if user.did_vote
      redirect_to :candidates
    else
      @candidates = Candidate.all()
      render :vote
    end
  end

  def tally_vote
    
    if (params[:candidate].nil?)
      redirect_to :vote, :flash => { :error => params[:candidate]}
    else
      #Count the vote
      candidate = Candidate.find_by_id(params[:candidate])
      if (candidate.votes.nil?)
        candidate.votes = '0'
      end
      candidate.votes = (Integer(candidate.votes) + 1).to_s
      candidate.save!

      user = current_user
      user.did_vote = true
      user.save

      redirect_to :candidates, :flash => {:notice => "Thanks for voting!"}
    end
  end
end
