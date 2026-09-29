module Seeds
  class AssessmentsSeeder
    def self.call
      new.call
    end

    def call
      Course.published.each { |course| seed_quiz_for(course) }
      Rails.logger.debug { "  Questions: #{Question.count}, Quizzes: #{Quiz.count}, Submissions: #{QuizSubmission.count}" }
    end

    private

    def seed_quiz_for(course)
      return if course.quizzes.any?

      quiz = course.quizzes.create!(
        title: "Quiz Akhir: #{course.title}",
        description: Faker::Lorem.paragraph,
        time_limit: 30,
        passing_score: 70,
        status: :published
      )

      5.times { |i| attach_question(quiz, i + 1) }
      seed_submissions(quiz)
    end

    def attach_question(quiz, position)
      question = Question.create!(
        content: Faker::Lorem.question,
        question_type: :multiple_choice,
        option_a: Faker::Lorem.word,
        option_b: Faker::Lorem.word,
        option_c: Faker::Lorem.word,
        option_d: Faker::Lorem.word,
        correct_answer: %w[A B C D].sample,
        difficulty: [:easy, :medium, :hard].sample,
        category: Faker::ProgrammingLanguage.name
      )
      quiz.quiz_questions.create!(question: question, position: position, points: 20)
    end

    def seed_submissions(quiz)
      quiz.course.students.limit(3).each do |student|
        submission = quiz.quiz_submissions.create!(user: student, status: :in_progress)
        answers = quiz.questions.pluck(:id).to_h do |qid|
          [qid.to_s, %w[A B C D].sample]
        end
        submission.update!(answers: answers)
        QuizGradingService.new(submission).call
      end
    end
  end
end
