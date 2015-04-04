class Comment < ActiveRecord::Base
  belongs_to :individual
  belongs_to :statement

  validates_presence_of :individual_id, :statement_id
end
