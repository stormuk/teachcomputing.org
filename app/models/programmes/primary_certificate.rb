module Programmes
  class PrimaryCertificate < Programme
    PROGRAMME_TITLE = 'Primary Computing Teaching'.freeze

    def path
      primary_certificate_path
    end

    def enrol_path(opts = {})
      enrol_primary_certificate_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end
  end
end
