module Api
  module V1
    class CertificatesController < BaseController
      def verify
        certificate = Certificate.find_by!(code: params.expect(:code))
        render json: CertificateSerializer.serialize(certificate)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Certificate not found" }, status: :not_found
      end
    end
  end
end
