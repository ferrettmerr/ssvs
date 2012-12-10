class Candidate < ActiveRecord::Base
  attr_accessible :name, :votes

  KEY = "2134d00d50490cba27ca7211666bae93"

  before_save :encrypt_votes

  after_save :decrypt_votes
  after_find :decrypt_votes

  protected
  
  def encrypt_votes
  	@iv = AES.iv(:base_64)
    self.votes = AES.encrypt(self.votes, KEY, {:iv => @iv}) unless self.votes.blank?
  end

  def decrypt_votes
    self.votes = AES.decrypt(self.votes, KEY) unless self.votes.blank?
  end
end
