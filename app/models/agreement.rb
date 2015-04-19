class Agreement < ActiveRecord::Base
  validates :individual_id, presence:true
  validates :statement_id, presence:true

  belongs_to :statement
  belongs_to :individual

  before_create :generate_hashed_id
  after_create :rm_opposite_agreement, :update_counters
  #after_save :update_entrepreneurship_statements_count
  #after_destroy :update_entrepreneurship_statements_count

  def short_url
    url.gsub(/.*http:\/\//,'').gsub(/.*www\./,'')[0..15] + "..."
  end

  def disagree?
    extent == 0
  end

  def agree?
    extent == 100
  end

  def to_param
    self.hashed_id
  end

  private

  def update_counters
    if agree?
      statement.agree_counter = statement.agree_counter + 1
    else
      statement.disagree_counter = statement.disagree_counter + 1
    end
    statement.save
  end

  def rm_opposite_agreement
    agreement = Agreement.where(statement: statement, individual: individual, extent: opposite_extent).first
    agreement.destroy if agreement
  end

  def opposite_extent
    extent == 100 ? 0 : 100
  end
  def generate_hashed_id
    self.hashed_id = loop do
      token = SecureRandom.urlsafe_base64.gsub("-", "_")
      break token unless Agreement.where('hashed_id' => token).first.present?
    end
  end

#  def update_entrepreneurship_statements_count
#    individual.entrepreneurship_statements_count = self.individual.statements.tagged_with("entrepreneurship").size
#    individual.save
#  end
end
