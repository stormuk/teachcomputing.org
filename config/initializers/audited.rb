require 'audited'

Audited::Railtie.initializers.each(&:run)

Audited.current_user_method = :authenticated_user

Rails.application.reloader.to_prepare do
  Audited.config do |config|
    config.audit_class = SupportAudit
  end
end
