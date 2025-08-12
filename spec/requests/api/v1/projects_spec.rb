require 'rails_helper'

RSpec.describe "Projects API", type: :request do
  let!(:user) { create(:user) }
  let!(:client) { create(:client, user: user) }
  let!(:projects) { create_list(:project, 2, client: client) }
  let(:project_id) { projects.first.id }

  describe "GET /api/v1/users/:user_id/clients/:client_id/projects" do
    it "returns all projects for a client" do
      get api_v1_user_client_projects_path(user_id: user.id, client_id: client.id)

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"].size).to eq(2)
    end
  end

   describe "GET /api/v1/users/:user_id/clients/:client_id/projects/:id" do
    it "returns a specific project" do
      get api_v1_user_client_project_path(user_id: user.id, client_id: client.id, id: project_id)

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(project_id)
    end
  end

   describe "POST /api/v1/users/:user_id/clients/:client_id/projects" do
    let(:valid_attributes) { attributes_for(:project) }

    it "creates a new project" do
      expect {
        post api_v1_user_client_projects_path(user_id: user.id, client_id: client.id), params: { project: valid_attributes }
      }.to change(Project, :count).by(1)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /api/v1/users/:user_id/clients/:client_id/projects/:id" do
    let(:updated_title) { "Updated Project Title" }

    it "updates the project" do
      patch api_v1_user_client_project_path(user_id: user.id, client_id: client.id, id: project_id), params: { project: { title: updated_title } }
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json["data"]["title"]).to eq(updated_title)
    end
  end

  describe "DELETE /api/v1/users/:user_id/clients/:client_id/projects/:id" do
    it "deletes the project" do
      expect {
        delete api_v1_user_client_project_path(user_id: user.id, client_id: client.id, id: project_id)
      }.to change(Project, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
