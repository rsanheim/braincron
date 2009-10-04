class ApplicationController < ActionController::Base
  include Clearance::Authentication
  helper :all
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password
end
