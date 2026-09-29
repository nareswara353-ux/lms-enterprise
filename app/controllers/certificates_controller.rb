class CertificatesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:verify], raise: false

  def index
    @certificates = current_user.certificates.includes(:course)
  end

  def show
    @certificate = current_user.certificates.find(params.expect(:id))
  end

  def verify
    @certificate = Certificate.find_by!(code: params.expect(:code))
    render :verify
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Sertifikat tidak ditemukan."
  end
end
