class VotesController < ApplicationController

  def vote
    #Testing until I get auth working
    params[:id] = 1
    @user = User.find(params[:id])
    @candidates = Candidate.all()
    render :vote
  end

  def tally_vote
    #Testing until I get auth working
    params[:id] = 1
    @user = User.find(params[:id])
    
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

      redirect_to :vote, :flash => { :notice => candidate.votes}
    end
  end
end
