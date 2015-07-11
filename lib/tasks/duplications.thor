class Duplications < Thor
  desc 'merge',
       'merge users with the same twitter'
   def merge
     require './config/environment'
     twitters.uniq.each do |twitter|
       user = first_user(twitter)
       if counters[twitter] > 1 && twitter.present?
         duplicated_users(user).each do |duplicated|
           duplicated.agreements.each do |agreement|
             agreement.individual_id = user.id
             puts "#{user.twitter} - #{agreement.statement.content}"
             puts agreement.save
           end
           puts "destroying #{duplicated.twitter}"
           duplicated.reload.destroy
         end
       end
     end
   end

   private

   def first_user(twitter)
     Individual.order(created_at: :asc).where(twitter: twitter).first
   end

   def twitters
     @twitters ||= Individual.all.map(&:twitter)
   end

   def counters
     counters = Hash.new(0)
     twitters.each do |twitter|
       counters[twitter] += 1
     end
     counters
   end

   def duplicated_users(user)
     Individual.where(twitter: user.twitter).where("id != ?", user.id)
   end
end
