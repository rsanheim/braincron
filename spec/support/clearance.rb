module Clearance
  module Shoulda
    module Helpers
      def sign_in_as(user)
        @controller.current_user = user
        return user
      end

      def sign_in
        sign_in_as Factory(:email_confirmed_user)
      end

      def sign_out
        @controller.current_user = nil
      end

      def blank_confirmation_options(attribute)
        warn "[DEPRECATION] blank_confirmation_options: not meant to be public, no longer used internally"
        opts = { attribute => attribute.to_s }
        opts.merge("#{attribute}_confirmation".to_sym => "")
      end

      def bad_confirmation_options(attribute)
        warn "[DEPRECATION] bad_confirmation_options: not meant to be public, no longer used internally"
        opts = { attribute => attribute.to_s }
        opts.merge("#{attribute}_confirmation".to_sym => "not_#{attribute}")
      end

      def assert_confirmation_error(model, attribute, message = "confirmation error")
        warn "[DEPRECATION] assert_confirmation_error: not meant to be public, no longer used internally"
        assert model.errors.on(attribute).include?("doesn't match confirmation"),
          message
      end
    end
  end
end
