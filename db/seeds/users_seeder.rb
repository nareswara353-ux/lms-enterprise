module Seeds
  class UsersSeeder
    def self.call
      new.call
    end

    def call
      User.find_or_create_by!(email: "admin@lms.test") do |u|
        u.name = "Admin LMS"
        u.password = "password123"
        u.password_confirmation = "password123"
        u.role = :admin
        u.confirmed_at = Time.current
      end

      3.times do |i|
        User.find_or_create_by!(email: "instructor#{i + 1}@lms.test") do |u|
          u.name = Faker::Name.name
          u.password = "password123"
          u.password_confirmation = "password123"
          u.role = :instructor
          u.bio = Faker::Lorem.paragraph(sentence_count: 3)
          u.confirmed_at = Time.current
        end
      end

      10.times do |i|
        User.find_or_create_by!(email: "student#{i + 1}@lms.test") do |u|
          u.name = Faker::Name.name
          u.password = "password123"
          u.password_confirmation = "password123"
          u.role = :student
          u.confirmed_at = Time.current
        end
      end

      Rails.logger.debug { "  Users: #{User.count}" }
    end
  end
end
