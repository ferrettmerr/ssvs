class UsersController < ApplicationController
  # GET /candidates
  # GET /candidates.json

  def index
    @users = User.all
    render :index
  end

  def validate_ssn
    @user = current_user
    if (@user.is_validated)
      redirect_to :vote
    else
      render :validate_ssn
    end
  end

  def verify_ssn
    user = current_user
    if (params[:ssn].nil? or params[:ssn].length == 0 or
      params[:password].nil? or params[:password].length == 0 or
      params[:confirm_password].nil? or params[:confirm_password].length == 0)
      redirect_to :validate_ssn, :flash => { :error => 'Please enter all fields'}
    elsif params[:ssn] != user.ssn
      redirect_to :validate_ssn, :flash => { :error => 'SSN does not match.'}
    elsif params[:password] != params[:confirm_password]
      redirect_to :validate_ssn, :flash => { :error => 'Passwords do not match.'}
    else
      user.is_validated = true
      user.password = params[:password]
      user.password_confirmation = params[:confirm_password]
      user.save
      redirect_to :vote, :flash => {:notice => "Account Verified!"}
    end
  end

  def create_user
    render :create_user
  end

  def add_user
    if (params[:email].nil? or params[:ssn].nil? or params[:email].length == 0 or params[:ssn].length == 0 )
      redirect_to :create_user, :flash => { :error => 'Please enter all fields'}
    else
      user = User.new
      user.email = params[:email]
      user.ssn = params[:ssn]
      user.save!
      redirect_to :candidates, :flash => { :info => 'User #{user.email} added!'}
    end
  end
end
