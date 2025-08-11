class Api::V1::ClientsController < ApplicationController
    before_action :set_user

    def index
        @clients = Client.all
        render json: { message: "Clients for #{@user.email}", data: @clients, status: :ok }
    end
    
    def show
        @client = Client.find(params[:id])
        render json: @client
    end

    def create
        @client = @user.clients.new(client_params)
        if @client.save
            render json: {message: "Client created for #{@user.email}", data: @client, status: :created}
        else
            render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @client = Client.find(params[:id])
        if @client.update(client_params)
            render json: { message: "Client updated", data: @client, status: :ok }
        else 
            render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    
    def set_user
        @user = User.find(params[:user_id])
    end
    def client_params
        params.require(:client).permit(:name, :email, :phone, :company_name, :user_id)
    end
end
