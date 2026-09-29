module Seeds
  class EnrollmentsSeeder
    def self.call
      new.call
    end

    def call
      students = User.student.to_a
      courses = Course.published.to_a
      return if students.empty? || courses.empty?

      students.each do |student|
        courses.sample(rand(2..4)).each do |course|
          enrollment = Enrollment.find_or_create_by!(user: student, course: course) do |e|
            e.status = :active
            e.progress = rand(0..100)
          end
          mark_completed_lessons(enrollment) if enrollment.progress > 50
        end
      end

      Rails.logger.debug { "  Enrollments: #{Enrollment.count}, Completions: #{LessonCompletion.count}" }
    end

    private

    def mark_completed_lessons(enrollment)
      lessons = enrollment.course.lessons.published
      completed_count = (lessons.count * enrollment.progress / 100.0).round
      lessons.limit(completed_count).each do |lesson|
        LessonCompletion.find_or_create_by!(user: enrollment.user, lesson: lesson)
      end
    end
  end
end
