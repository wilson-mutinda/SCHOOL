class UserService

  include SearchHelper

  def initialize(params = {})
    @params = params || {}
    @users = User.all.order(:id).to_a
    @target_param = params[:slug]
    @user = search_user_by_slug(@users, @target_param)
  end

  def create_user
    # email_param
    email_param = normalize_user_email
    if email_param.is_a?(Hash) && email_param.key?(:errors)
      return email_param
    end

    # phone_param
    phone_param = normalize_user_phone
    if phone_param.is_a?(Hash) && phone_param.key?(:errors)
      return phone_param
    end

    # password param
    password_result = normalize_password
    if password_result.is_a?(Hash) && password_result.key?(:errors)
      return password_result
    end

    # create_user
    created_user = User.new(
      email: email_param,
      phone: phone_param,
      password: password_result[:password],
      password_confirmation: password_result[:password_confirmation],
      role: "Admin"
    )

    if created_user.save
      { success: true, message: "User created successfully!", info: created_user }
    else
      { success: false, errors: created_user.errors.full_messages }
    end
  end

  # single_user
  def single_user
    if @user.is_a?(Hash) && @user.key?(:errors)
      return { success: false, errors: @user }
    else
      return { success: true, info: @user }
    end
  end

  # all_users
  def all_users
    users = User.all.order(:email).to_a
    if users.empty?
      return { success: false, errors: "Empty List!" }
    else
      return { success: true, info: users }
    end
  end

  # update_user
  def update_user
    if @user.is_a?(Hash) && @user.key?(:errors)
      return @user
    end

    updated_user_params = {}

    # email_param
    if @params.key?(:email)
      email_param = normalize_update_user_email
      if email_param.is_a?(Hash) && email_param.key?(:errors)
        return email_param
      end
      updated_user_params[:email] = email_param
    end

    # phone_param
    if @params.key?(:phone)
      phone_param = normalize_update_user_phone
      if phone_param.is_a?(Hash) && phone_param.key?(:errors)
        return phone_param
      end
      updated_user_params[:phone] = phone_param
    end

    # password_params
    password_params = normalize_password
    if password_params.is_a?(Hash) && password_params.key?(:errors)
      return password_params
    end
    updated_user_params[:password] = password_params[:password]
    updated_user_params[:password_confirmation] = password_params[:password_confirmation]

    # update user
    updated_user = @user.update(updated_user_params)
    if updated_user
      { success: true, message: "User updated successfully!", info: @user }
    else
      { success: false, errors: @user.errors.full_messages }
    end
  end

  # delete_user
  def delete_user
    if @user.is_a?(Hash) && @user.key?(:errors)
      return @user
    end

    # check if user was deleted
    if @user.is_user_deleted?
      return { success: false, errors: "User has been deleted!"}
    else
      @user.delete_user
      return { success: true, message: "User soft deleted succesfully!" }
    end
  end

  # restore_user
  def restore_user
    user = User.unscoped.find_by(id: @params[:id])
    if user
      # check if user was deleted
      unless user.is_user_deleted?
        return { success: false, errors: "User was not deleted!"}
      else
        user.restore_user
        return { success: true, message: "User restored successfully!" }
      end
    else
      return { success: false, errors: "User not found!"}
    end
  end

  private

  def normalize_update_user_phone
    phone_param = @params[:phone].to_s.gsub(/\s+/, '')
    if phone_param.present?
      # phone format
      if phone_param.match?(/\A07\d{8}\z/)
        phone_param = phone_param.sub(/\A07/, "2547")
      elsif phone_param.match?(/\A01\d{8}/)
        phone_param = phone_param.sub(/\A01/, "2541")
      end

      unless phone_param.match?(/\A254(1|7)\d{8}\z/)
        return { errors: "Invalid phone format!"}
      end

      # check phone uniqueness
      norm_phone = unique_phone(@users, phone_param, @user.id)
      if norm_phone.is_a?(Hash) && norm_phone.key?(:errors)
        return norm_phone
      end
      norm_phone
    end
  end

  def normalize_update_user_email
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email_param.present?
      # email format
      unless email_param.match?(/\A[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[A-Za-z]{2,}\z/)
        return { errors: 'Invalid email format!'}
      end

      # check email uniqueness
      norm_email = unique_email(@users, email_param, @user.id)
      if norm_email.is_a?(Hash) && norm_email.key?(:errors)
        return norm_email
      end

      norm_email
    end
  end

  def normalize_password
    password_param = @params[:password].to_s
    password_confirmation_param = @params[:password_confirmation].to_s

    if password_param.present? && password_confirmation_param.blank?
      return { errors: { password_confirmation: "Please input password confirmation!"}}
    elsif password_param.blank? && password_confirmation_param.present?
      return { errors: { password: "Please input password!"}}
    elsif password_param.blank? && password_confirmation_param.blank?
      return { errors: { 
        password: "Please input pasword!",
        password_confirmation: "Please input password confirmation!"
      }}
    end

    unless password_param == password_confirmation_param
      return { errors: { password_confirmation: "Password Mismatch!"}}
    end

    unless password_param.length >= 8
      return { errors: { password: "Password should have at least 8 characters!"}}
    end

    unless password_param.match?(/\d/) && password_param.match?(/[A-Za-z]/)
      return { errors: { password: "Password should have both characters and letters!"}}
    end

    { password: password_param, password_confirmation: password_confirmation_param }
  end

  def normalize_user_phone
    phone_param = @params[:phone].to_s.gsub(/\s+/, '')
    if phone_param.blank?
      return { errors: "Please input phone!"}
    end

    if phone_param.match?(/\A07\d{8}\z/)
      phone_param = phone_param.sub(/\A07/, "2547")
    elsif phone_param.match?(/\A01\d{8}/)
      phone_param = phone_param.sub(/\A01/, "2541")
    end

    unless phone_param.match?(/\A254(1|7)\d{8}\z/)
      return { errors: "Invalid phone format!"}
    end

    norm_phone = unique_phone_search(@users, phone_param)
    if norm_phone.is_a?(Hash) && norm_phone.key?(:errors)
      return norm_phone
    end

    norm_phone
  end

  def normalize_user_email
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email_param.blank?
      return { errors: 'Please input email!'}
    end

    # normalize email
    unless email_param.match?(/\A[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[A-Za-z]{2,}\z/)
      return { errors: 'Invalid email format!'}
    end
    norm_email = unique_email_search(@users, email_param)
    if norm_email.is_a?(Hash) && norm_email.key?(:errors)
      return norm_email
    end

    norm_email
  end

end