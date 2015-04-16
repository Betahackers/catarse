module Project::CustomValidators
  extend ActiveSupport::Concern

  included do
    @@routes = Rails.application.routes.routes
    validate :permalink_cant_be_route, allow_nil: true
    validate :iban_is_valid, allow_blank: true
    validate :iban_or_paypal_present
    
    def self.get_routes
      @@mapped_routes ||= @@routes.inject(Set.new) do |memo, item|
        memo << $1 if item.path.spec.to_s.match(/^\/([\w]+)\S/)
        memo
      end
    end

    def self.permalink_on_routes?(permalink)
      permalink && self.get_routes.include?(permalink.downcase)
    end

    def permalink_cant_be_route
      errors.add(:permalink, I18n.t("activerecord.errors.models.project.attributes.permalink.invalid")) if Project.permalink_on_routes?(permalink)
    end
    
    def iban_or_paypal_present
      unless iban.present? || paypal_email_address.present?
        errors.add(:iban, I18n.t("activerecord.errors.models.project.attributes.iban_and_paypal.blank"))
      end
    end
    
    
    def iban_is_valid
      unless iban.blank? || IBANTools::IBAN.valid?(iban)
        errors.add(:iban, I18n.t("activerecord.errors.models.project.attributes.iban.invalid"))
      end
    end
  end
end
