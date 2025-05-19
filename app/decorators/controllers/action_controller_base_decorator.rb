# app/decorators/controllers/action_controller_base_decorator.rb
require_dependency 'refinery/authentication/devise/role'
require_dependency 'refinery/authentication/devise/authorisation_manager'

module Controllers
  module ActionControllerBaseDecorator
    def self.prepended(base)
      base.prepend_before_action :detect_authentication_devise_user!
    end

    protected

    def refinery_users_exist?
      # Accede al namespace completo desde el root
      ::Refinery::Authentication::Devise::Role[:refinery].users.any?
    end

    private

    def refinery_authorisation_manager
      @refinery_authorisation_manager ||= ::Refinery::Authentication::Devise::AuthorisationManager.new
    end

    def detect_authentication_devise_user!
      if current_authentication_devise_user
        refinery_authorisation_manager.set_user!(current_authentication_devise_user)
      end
    end
  end
end

ActionController::Base.prepend Controllers::ActionControllerBaseDecorator
