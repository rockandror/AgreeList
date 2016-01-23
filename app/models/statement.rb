class Statement < ActiveRecord::Base
  has_many :agreements, dependent: :destroy
  has_many :individuals, :through => :agreements
  has_many :comments
  belongs_to :individual

  acts_as_taggable

  validates :content, presence: true, length: { maximum: 140 }
  before_create :generate_hashed_id, :set_entrepreneurship_tag

  def agreements_in_favor(args = {})
    a = agreements.select{ |a| a.agree? }
    if args[:order] == "date"
      a.sort_by{ |a| - a.created_at.to_i }
    else
      a.sort_by{ |a| - ranking(a) }
    end
  end
  alias_method :supporters, :agreements_in_favor

  def agreements_against(args = {})
    a = agreements.select{ |a| a.disagree? }
    if args[:order] == "date"
      a.sort_by{ |a| - a.created_at.to_i }
    else
      a.sort_by{ |a| - ranking(a) }
    end
  end
  alias_method :detractors, :agreements_against

  def to_param
    "#{content.parameterize}-#{hashed_id}"
  end

  private

  def ranking(agreement)
    r = agreement.individual.ranking
    r == 0 ? agreement.individual.followers_count : r
  end

  def generate_hashed_id
    self.hashed_id = loop do
      token = SecureRandom.urlsafe_base64[0,12].downcase.gsub("-", "a").gsub("_", "b")
      break token unless Statement.where('hashed_id' => token).first.present?
    end
  end

  def set_entrepreneurship_tag
    self.tag_list.add("others") unless self.tag_list.any?
  end
end
