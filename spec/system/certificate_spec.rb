require 'rails_helper'

RSpec.describe "Certificate", type: :system do
  let(:student) { create(:user, :student) }
  let(:course) { create(:course, :free, status: :published) }
  let!(:certificate) { create(:certificate, user: student, course: course) }

  describe "viewing certificates as student" do
    before { sign_in_as(student) }

    it "shows list of certificates" do
      visit certificates_path
      expect(page).to have_content("Sertifikat Saya")
      expect(page).to have_content(course.title)
    end

    it "shows certificate detail" do
      visit certificate_path(certificate)
      expect(page).to have_content(certificate.code)
      expect(page).to have_content(student.name)
    end
  end

  describe "public certificate verification" do
    it "verifies a valid certificate code" do
      visit verify_certificate_path(certificate.code)
      expect(page).to have_content("Sertifikat VALID")
    end

    it "rejects invalid certificate code" do
      visit "/certificates/INVALID/verify"
      expect(page).to have_content("Sertifikat tidak ditemukan")
    end
  end
end
