class ReasonCategory < ActiveRecord::Base
  has_many :agreements, dependent: :nullify
end
