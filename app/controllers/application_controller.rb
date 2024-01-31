class ApplicationController < ActionController::API
    include JwtConcern
    attr_reader :current_user

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def authenticate_user
      @current_user = user_from_token
       unless @current_user
        unless performed?
          render :unauthorized, status: :unauthorized
        end
       end
    end

    def authorize_todo_access!
        return if @todo.user_id == current_user.id

        render :unauthorized, status: :unauthorized
        return
    end

    private
    def not_found
        render :not_found, status: :not_found
    end

    def user_from_token
      auth_header = request.headers['Authorization']
      unless auth_header.present?
        render :unauthorized, status: :unauthorized
        return
      end

      token_parts = auth_header.split(' ')
      return nil unless token_parts.length == 2 && token_parts.first.downcase == 'bearer'

      token = token_parts.last
      decoded_token = decode_token(token) rescue nil

      unless decoded_token
        render json: { error: 'Expired Token' }, status: :unauthorized
        return
      end

      user_id = decoded_token["user_id"]

      User.find(user_id)
    end 
end