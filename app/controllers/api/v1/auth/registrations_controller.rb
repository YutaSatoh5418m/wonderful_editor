class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
    # protect_from_forgery with: :null_session
    def cancel
    end

    def new
    end

    def edit
    end

    def update
    end

    def destroy
    end

    def create
      super
    end
    
    private
  
      def sign_up_params
        params.permit(:name, :email, :password, :password_confirmation, :confirmed_at)
      end
      
      def account_update_params
        params.permit(:name, :email)
      end
  end
