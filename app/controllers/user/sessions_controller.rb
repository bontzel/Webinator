class User::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
skip_before_filter :verify_authenticity_token, :only => :create

   # GET /resource/sign_in
   # def new
   #  super
   # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    if resource.profile
      user_profile_path(resource.id, resource.profile.id)
    else
      new_user_profile_path(resource.id)
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
