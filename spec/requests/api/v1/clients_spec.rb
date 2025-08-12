require 'rails_helper'

RSpec.describe "Clients API", type: :request do
  let!(:user)    { create(:user) }
  let!(:clients) { create_list(:client, 2, user: user) }
  let(:client) { clients.first }

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

   describe "GET /api/v1/users/:user_id/clients/:id" do
    it "returns a specific client" do
      get api_v1_user_client_path(user_id: user.id, id: client.id)

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(client.id)
      expect(json["name"]).to eq(client.name)
    end
  end

  describe "PATCH /api/v1/users/:user_id/clients/:id" do
    it "updates an existing client" do
      update_params = { client: { name: "Updated Client Name" } }

      patch api_v1_user_client_path(user_id: user.id, id: client.id), params: update_params

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["name"]).to eq("Updated Client Name")
    end
  end

end
