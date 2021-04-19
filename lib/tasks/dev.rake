task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    FollowRequest.destroy_all
    User.destroy_all
  end

12.times do
  name = p Faker::Name.female_first_name
  u = User.create(
    email: "#{name}@example.com",
    username: name,
    password: "password",
    private: [true, false].sample
  )
  end
  p "#{User.count} users have been created."

  users = User.all

    users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end

      if rand < 0.75
          second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end

  p "#{FollowRequest.count} follow requests have been created."
end
