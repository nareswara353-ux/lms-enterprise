module Seeds
  class InteractionsSeeder
    def self.call
      new.call
    end

    def call
      seed_discussions
      seed_payments
      seed_certificates
      seed_notifications
      Rails.logger.debug { "  Topics: #{DiscussionTopic.count}, Posts: #{DiscussionPost.count}" }
      Rails.logger.debug { "  Payments: #{Payment.count}, Certificates: #{Certificate.count}, Notifications: #{Notification.count}" }
    end

    private

    def seed_discussions
      Course.published.limit(3).each do |course|
        next if course.discussion_topics.any?

        topic = course.discussion_topics.create!(
          user: course.instructor,
          title: Faker::Lorem.sentence(word_count: 5),
          content: Faker::Lorem.paragraph,
          status: :open
        )
        course.students.limit(3).each do |student|
          topic.posts.create!(user: student, content: Faker::Lorem.paragraph)
        end
      end
    end

    def seed_payments
      Payment.where(status: :successful).first_or_create! do |p|
        enrollment = Enrollment.first
        next unless enrollment

        p.user = enrollment.user
        p.course = enrollment.course
        p.status = :successful
        p.amount = enrollment.course.price
        p.currency = "idr"
        p.stripe_payment_intent_id = "pi_#{SecureRandom.hex(12)}"
      end
    end

    def seed_certificates
      Enrollment.completed.each do |enrollment|
        Certificate.find_or_create_by!(user: enrollment.user, course: enrollment.course)
      end
    end

    def seed_notifications
      User.student.limit(5).each do |student|
        Notification.find_or_create_by!(
          recipient: student,
          message: "Selamat datang di LMS, #{student.name}!"
        )
      end
    end
  end
end
