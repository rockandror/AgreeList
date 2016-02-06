class ReasonCategory < ActiveRecord::Base
  include TopAgreement
  has_many :agreements, dependent: :nullify
end
