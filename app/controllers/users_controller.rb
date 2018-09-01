class UsersController < ApplicationController
  include TokenAuthenticatable
  before_action :find_user, only: %w[show destroy update]
  skip_before_action :authenticate_user, only: %w[authenticate create]
  skip_before_action :verify_authenticity_token, only: %w[authenticate]

  def show

  end

  def create
    # require an invite code before allowing anyone to sign up
  end

  def destroy
    # require current password before allowing account destroyed
  end

  def update
    # validate current password before allowing new password to be set
  end

  def authenticate
    token_command = AuthenticateUserCommand.call(*params.slice(:email, :password).values)

    if token_command.success?
      render json: token_command.result
    else
      render json: { error: token_command.errors }, status: :unauthorized
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end