module Controllers
  module Refinery
    module ApplicationControllerDecorator
      private

      def authorisation_manager
        # Método definido en action_controller_base_decorator.rb
        refinery_authorisation_manager
      end
    end
  end
end

# Precargar la clase original
require_dependency "refinery/application_controller"

# Aplicar el decorador
Refinery::ApplicationController.prepend Controllers::Refinery::ApplicationControllerDecorator
