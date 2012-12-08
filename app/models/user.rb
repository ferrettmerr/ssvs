class User < ActiveRecord::Base
  attr_accessible :didVote, :name, :ssn
end
