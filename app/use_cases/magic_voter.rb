class MagicVoter
  attr_accessor :voter
  attr_reader :name, :twitter, :email, :current_user, :adding_myself

  def initialize(args)
    @email = args[:email]
    @twitter = args[:twitter]
    @name = args[:name]
    @current_user = args[:current_user]
    @adding_myself = args[:adding_myself]
  end

  def find_or_create!
    find_or_create_voter
    Individual.create(email: email) if !current_user && !adding_myself && email.present?
    self.voter
  end

  private

  def find_or_create_voter
    self.voter = find_or_build_voter
    self.voter.name = name if name.present?
    self.voter.email = email if adding_myself && email.present?
    self.voter.save!
  end

  def find_or_build_voter
    if adding_myself
      current_user || twitter ? find_or_build_twitter_user : build_user
    else
      twitter ? find_or_build_twitter_user : build_user
    end
  end

  def build_user
    Individual.new(name: name)
  end

  def find_twitter_user
    Individual.find_by_twitter(twitter) || Individual.new(twitter: twitter)
  end

  #def find_or_build_user
  #  twitter ? find_or_build_twitter_user : build_user
  #end

  def find_or_build_twitter_user
    Individual.where(twitter: twitter).first || Individual.new(twitter: twitter)
  end
end
