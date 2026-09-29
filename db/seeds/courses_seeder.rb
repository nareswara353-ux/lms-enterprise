module Seeds
  class CoursesSeeder
    COURSE_TEMPLATES = [
      { title: "Ruby on Rails Fundamentals", level: :beginner, price: 0 },
      { title: "Advanced Rails Patterns", level: :advanced, price: 149_000 },
      { title: "PostgreSQL for Developers", level: :intermediate, price: 99_000 },
      { title: "Hotwire & Turbo Mastery", level: :intermediate, price: 129_000 },
      { title: "API Design with Rails", level: :advanced, price: 179_000 }
    ].freeze

    def self.call
      new.call
    end

    def call
      instructors = User.instructor.limit(3).to_a
      return if instructors.empty?

      COURSE_TEMPLATES.each_with_index do |template, idx|
        instructor = instructors[idx % instructors.size]
        course = Course.find_or_create_by!(title: template[:title]) do |c|
          c.instructor = instructor
          c.description = Faker::Lorem.paragraph(sentence_count: 5)
          c.level = template[:level]
          c.price = template[:price]
          c.status = :published
          c.duration = [60, 120, 180, 240].sample
        end
        seed_modules(course)
      end

      Rails.logger.debug { "  Courses: #{Course.count}, Modules: #{CourseModule.count}, Lessons: #{Lesson.count}" }
    end

    private

    def seed_modules(course)
      return if course.modules.any?

      rand(3..5).times do |m_idx|
        modul = course.modules.create!(
          title: "Modul #{m_idx + 1}: #{Faker::Lorem.sentence(word_count: 3)}",
          description: Faker::Lorem.paragraph,
          position: m_idx + 1,
          status: :published
        )
        seed_lessons(modul)
      end
    end

    def seed_lessons(modul)
      rand(4..6).times do |l_idx|
        modul.lessons.create!(
          title: "Lesson #{l_idx + 1}: #{Faker::Lorem.sentence(word_count: 4)}",
          content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
          video_url: "https://example.com/video/#{SecureRandom.hex(4)}",
          duration: [5, 10, 15, 20].sample,
          position: l_idx + 1,
          status: :published,
          lesson_type: [:video, :text].sample
        )
      end
    end
  end
end
