require 'spec_helper'

describe CalendarsController do

  let(:valid_attributes) { { title: "test", description: "a longer text"} }

  describe "GET show" do
    it "assigns the requested calendar as @calendar" do
      calendar = Calendar.create! valid_attributes
      get :show, id: calendar.token_read
      expect(assigns(:calendar)).to eq(calendar)
    end

    it "assigns the related events as @events" do
      calendar = Calendar.create! valid_attributes
      FactoryGirl.create(:event, calendar: calendar)
      get :show, id: calendar.token_read
      expect([assigns(:events)]).to include(calendar.events)
    end
  end

  describe "GET show with format json read-only" do 
    let(:calendar) { FactoryGirl.create(:calendar_with_events) }
    before { get :show, id: calendar.token_read, format: :json }

    it "contains the calendars read token" do
      expect(response.body).to have_content(calendar.token_read)
    end

    it "contains the first event that belongs to the calendar" do
      expect(response.body).to have_content(calendar.events.first.title)
    end

    it "will not output the write token, because that'd be dangerous!" do
      expect(response.body).not_to have_content(calendar.token_write)
    end
  end

  describe "GET show with format json read-write" do 
    let(:calendar) { FactoryGirl.create(:calendar_with_events) }
    before { get :show, id: calendar.token_write, format: :json }

    it "contains the write token, because you had it all the way" do 
      expect(response.body).to have_content(calendar.token_write)
    end
  end



  describe "GET new" do
    it "assigns a new calendar as @calendar" do
      get :new, {}
      expect(assigns(:calendar)).to be_a_new(Calendar)
    end
  end

  describe "GET edit" do
    it "assigns the requested calendar as @calendar" do
      calendar = Calendar.create! valid_attributes
      get :edit, id: calendar.token_write
      expect(assigns(:calendar)).to eq(calendar)
    end
  end

  describe "POST upload" do
    before :all do
      fixture_file = Rails.root.join('spec', 'fixtures', 'calendars', 'no_events.ics')
      opts = {type: "text/calendar",
              tempfile: fixture_file,
              filename: fixture_file.basename.to_s
      }
      @local_file = ActionDispatch::Http::UploadedFile.new(opts)
    end

    it "redirects to the previous calendar" do
      calendar = Calendar.create! valid_attributes
      post :upload, id: calendar.token_write, ical: @local_file
      expect(response).to redirect_to(calendar)
    end
  end

  describe "GET download" do
    it "redirect to the previous calendar" do
      calendar = Calendar.create! valid_attributes
      get :download, id: calendar.token_write
      expect(response.status).to be 200
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Calendar" do
        expect {
          post :create, {calendar: { title: "Some title" }}
        }.to change(Calendar, :count).by(1)
      end

      it "assigns a newly created calendar as @calendar" do
        post :create, {calendar: { title: "Some title" }}
        expect(assigns(:calendar)).to be_a(Calendar)
        expect(assigns(:calendar)).to be_persisted
      end

      it "redirects to the created calendar" do
        post :create, {calendar: { title: "Some title" }}
        expect(response).to redirect_to(Calendar.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved calendar as @calendar" do
        # Trigger the behavior that occurs when invalid params are submitted
        Calendar.any_instance.stub(:save).and_return(false)
        post :create, {:calendar => { token_read: "invalid" }}
        expect(assigns(:calendar)).to be_a_new(Calendar)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Calendar.any_instance.stub(:save).and_return(false)
        post :create, {:calendar => { token_read: "invalid value" }}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested calendar" do
        calendar = Calendar.create! valid_attributes
        # Assuming there are no other calendars in the database, this
        # specifies that the Calendar created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Calendar.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, id: calendar.token_write, :calendar => { "title" => "MyString" }
      end

      it "assigns the requested calendar as @calendar" do
        calendar = Calendar.create! valid_attributes
        put :update, {id: calendar.token_write, calendar: { title: "test" }}
        expect(assigns(:calendar)).to eq(calendar)
      end

      it "redirects to the calendar" do
        calendar = Calendar.create! valid_attributes
        put :update, {id: calendar.token_write, calendar: { title: "test" }}
        expect(response.status).to be 302
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        calendar = Calendar.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Calendar.any_instance.stub(:save).and_return(false)
        put :update, {id: calendar.token_write, :calendar => { token_read: "invalid value" }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested calendar" do
      calendar = Calendar.create! valid_attributes
      expect {
        delete :destroy, {id: calendar.token_write}
      }.to change(Calendar, :count).by(-1)
    end

    it "redirects to the calendars list" do
      calendar = Calendar.create! valid_attributes
      delete :destroy, {id: calendar.token_write}
      expect(response).to redirect_to(new_calendar_path)
    end
  end
end
