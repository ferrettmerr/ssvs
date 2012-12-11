class UsersController < ApplicationController
  # GET /candidates
  # GET /candidates.json

  before_filter :authenticate_user!

  def validate_ssn
    @user = current_user
    if (@user.is_validated)
      redirect_to :vote
    else
      render :validate_ssn
    end
  end

  def verify_ssn
    if (params[:ssn].nil?)
      redirect_to :validate_ssn, :flash => { :error => 'Please enter a SSN.'}
    elsif params[:ssn] != @user.ssn
      redirect_to :validate_ssn, :flash => { :error => 'SSN does not match.'}
    else
      user = current_user
      user.is_validated = true
      user.save
      redirect_to :vote, :flash => {:notice => "Account Verified!"}
    end
  end

end
