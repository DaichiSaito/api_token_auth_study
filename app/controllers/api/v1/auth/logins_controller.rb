module Api
  module V1
    module Auth
      class LoginsController < ApplicationController

        def login
          user = Authentication.find_by(uid: params[:uid], provider: params[:provider])&.user
          if user
            # render json: user, status: :ok
            token = Jwt::TokenProvider.(user_id: user.id)
            render json: {user: user, token: token}
          else
            user = User.create(email: params[:email], password: SecureRandom.urlsafe_base64)
            user.authentications.create(uid: params[:uid], provider: params[:provider])
            render json: user, status: :created
          end
        end

      end
    end
  end
end
