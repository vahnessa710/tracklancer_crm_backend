require 'rails_helper'

RSpec.describe "Clients API", type: :request do
  let!(:user)    { create(:user) }
  let!(:clients) { create_list(:client, 2, user: user) }

  describe "GET /api/v1/users/:user_id/clients" do
    it "returns all clients for a user" do
      get api_v1_user_clients_path(user_id: user.id)

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"].size).to eq(2)
    end
  end

  describe "POST /api/v1/users/:user_id/clients" do
    it "creates a new client" do
      client_params = { client: attributes_for(:client) }

      expect {
        post api_v1_user_clients_path(user_id: user.id), params: client_params
      }.to change(Client, :count).by(1)

      expect(response).to have_http_status(:ok)
    end
  end
end
