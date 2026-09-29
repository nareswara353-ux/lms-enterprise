require_relative "seeds/users_seeder"
require_relative "seeds/courses_seeder"
require_relative "seeds/enrollments_seeder"
require_relative "seeds/assessments_seeder"
require_relative "seeds/interactions_seeder"

Rails.logger.debug "Seeding database..."
Seeds::UsersSeeder.call
Seeds::CoursesSeeder.call
Seeds::EnrollmentsSeeder.call
Seeds::AssessmentsSeeder.call
Seeds::InteractionsSeeder.call
Rails.logger.debug "Seeding complete."
