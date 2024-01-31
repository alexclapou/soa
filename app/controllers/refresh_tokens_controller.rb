class RefreshTokensController < ApplicationController
    def create
        username = params[:name]
        user = User.find_by(name: username)

        unless user
            render json: { error: 'Invalid credentials' }, status: :unauthorized
            return
        end

        @token = create_token(user, 10.seconds.from_now.to_i)
        @refresh_token = create_token(user, 10.years.from_now.to_i)

        RefreshToken.create(user_id: user.id, token: @refresh_token)
        render :token
        return
    end

    def refresh
        # search for user refresh token
        refresh_token = params[:refresh_token]
        valid_token = RefreshToken.find_by(token: refresh_token)

        # if does not exist return an error message
        unless valid_token
            render json: { error: 'Invalid token' }, status: :unauthorized
            return
        end

        # if it s valid generate a pair of tokens
        user = valid_token.user
        @token = create_token(user, 10.minutes.from_now.to_i)
        @refresh_token = create_token(user, 10.years.from_now.to_i)

        # create the new refresh_token / delete the old one 
        RefreshToken.create(user_id: user.id, token: @refresh_token)
        valid_token.destroy

        # return JSON response
        render :token
    end

    def create_token(user, expiration_time)
        payload = { user_id: user.id, exp: expiration_time }
        encode_token(payload)
    end
end
