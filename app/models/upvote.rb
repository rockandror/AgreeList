class Upvote < ActiveRecord::Base
  belongs_to :agreement
  belongs_to :individual
  validates_presence_of :agreement_id, :individual_id
end
