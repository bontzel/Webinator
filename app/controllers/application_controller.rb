class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def reset
    Rails.application.eager_load!
    ActiveRecord::Base.descendants.each { |c| c.delete_all unless c == ActiveRecord::SchemaMigration  }
  end

end
