class StaticPagesController < ApplicationController
  before_action :statements_to_vote, only: :home
  def join
    @individual = current_user
  end

  def polar
  end

  def home
    if Rails.env == "test"
      test_home
    else
      @statements = urls.map{ |s| Statement.find_by_hashed_id(s.split("-").last) }
      @individuals = twitters.map{ |t| Individual.find_by_twitter(t) }
    end
  end

  def contact
  end

  private

  def statements_to_vote
    if current_user
      @statements_to_vote = (Statement.tagged_with("entrepreneurship") - current_user.statements).map{|s| [s.id, s.content]}
    end
  end

  def test_home
    @statements, @individuals = [], []
    9.times do
      @statements << Statement.first
      @individuals << Individual.first
    end
  end

  def urls
    %w(http://www.agreelist.com/s/launch-early-get-feedback-and-start-iterating-kibothy610sj
       http://www.agreelist.com/s/entrepreneurs-should-have-a-sense-of-purpose-0u5gaxuav1w8
       http://www.agreelist.com/s/seek-out-negative-feedback-5brqzh7xaj5b
       http://www.agreelist.com/s/a-single-founder-in-a-startup-is-a-mistake-5udqtimqiicb
       http://www.agreelist.com/s/location-is-important-for-a-startup-zfrtumvrwtyd
       http://www.agreelist.com/s/stay-self-funded-as-long-as-possible-73rbrkrvztwb
       http://www.agreelist.com/s/don-t-go-all-in-with-your-business-re3xkpjeunfp
       http://www.agreelist.com/s/go-with-your-gut-rx54xxorby6y
       http://www.agreelist.com/s/don-t-give-up-olyhqve6j6sf
       http://www.agreelist.com/s/set-goals-4m7m7oidosa8)
  end

  def twitters
    %w(reidhoffman edyson elonmusk paulg petercohan gmc tferriss richardbranson dilbert_daily)
  end
end
