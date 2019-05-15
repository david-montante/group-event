require 'rails_helper'

RSpec.describe Api::V1::GroupEventsController, type: :controller do
  
  before(:each) do
    @empty_event = GroupEvent.create
  end
    
  describe "GET /api/v1/group_events#index" do
    context "API" do
      before(:each) do
        get :index, as: :json
      end
      
      it "returns the active events" do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).count).to eq GroupEvent.active.count
      end
    end
  end
  
  describe "GET /api/v1/group_events/:id#show" do
    context "API" do
      before(:each) do
        get :show, id: @empty_event.id
      end
      
      it "returns the event" do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["id"]).to eq @empty_event.id
      end
    end
  end
  
  describe "POST /api/v1/group_events#post" do
    context "API" do
      before(:each) do
        post :create, {:name => "My Event",
                       :location => "San Francisco",
                       :start_date => "1-1-2019",
                       :end_date => "1-2-2019",
                       :published => "true" }
      end
      
      it "returns the created event with no duration" do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["name"]).to eq "My Event"
        expect(JSON.parse(response.body)["location"]).to eq "San Francisco"
        expect(JSON.parse(response.body)["start_date"]).to eq "2019-01-01"
        expect(JSON.parse(response.body)["end_date"]).to eq "2019-02-01"
        expect(JSON.parse(response.body)["duration"]).to eq 31
        expect(JSON.parse(response.body)["published"]).to eq true
        expect(JSON.parse(response.body)["deleted"]).to eq false
      end
    end
  end
  
  describe "POST /api/v1/group_events#post" do
    context "API" do
      before(:each) do
        post :create, {:name => "My Event",
                       :location => "San Francisco",
                       :start_date => "1-1-2019",
                       :duration => 31,
                       :published => "true" }
      end
      
      it "returns the created event with no end date" do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["name"]).to eq "My Event"
        expect(JSON.parse(response.body)["location"]).to eq "San Francisco"
        expect(JSON.parse(response.body)["start_date"]).to eq "2019-01-01"
        expect(JSON.parse(response.body)["end_date"]).to eq "2019-02-01"
        expect(JSON.parse(response.body)["duration"]).to eq 31
        expect(JSON.parse(response.body)["published"]).to eq true
        expect(JSON.parse(response.body)["deleted"]).to eq false
      end
    end
  end
  
  describe "POST /api/v1/group_events#post" do
    context "API" do
      before(:each) do
        post :create, {:name => "My Event",
                       :start_date => "1-1-2019",
                       :end_date => "1-2-2019",
                       :published => "true" }
      end
      
      it "returns the created event not published for location" do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["name"]).to eq "My Event"
        expect(JSON.parse(response.body)["location"]).to eq nil
        expect(JSON.parse(response.body)["start_date"]).to eq "2019-01-01"
        expect(JSON.parse(response.body)["end_date"]).to eq "2019-02-01"
        expect(JSON.parse(response.body)["duration"]).to eq 31
        expect(JSON.parse(response.body)["published"]).to eq false
        expect(JSON.parse(response.body)["deleted"]).to eq false
      end
    end
  end
  
  describe "PUT /api/v1/group_events#put" do
    context "API" do
      before(:each) do
        put :update, {:id => @empty_event.id,
                      :name => "My Nice Event",
                      :location => "Bay Area"  }
      end
      
      it "returns the updated event" do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["name"]).to eq "My Nice Event"
        expect(JSON.parse(response.body)["location"]).to eq "Bay Area"
        expect(JSON.parse(response.body)["start_date"]).to eq nil
        expect(JSON.parse(response.body)["end_date"]).to eq nil
        expect(JSON.parse(response.body)["duration"]).to eq nil
        expect(JSON.parse(response.body)["published"]).to eq false
        expect(JSON.parse(response.body)["deleted"]).to eq false
      end
    end
  end
  
  describe "DELETE /api/v1/group_events#post" do
    context "API" do
      before(:each) do
        delete :destroy, {:id => @empty_event.id }
      end
      
      it "returns the deleted event" do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["deleted"]).to eq true
      end
    end
  end
end

