require 'spec_helper'

describe Uploader do
  it { should respond_to(:upload) }

  after :all do
    clear_uploads_directory
  end

  describe ".upload" do
    before :all do
      fixture_file = Rails.root.join('spec', 'fixtures', 'calendars', 'no_events.ics')
      opts = {type: "text/calendar",
              tempfile: fixture_file,
              filename: fixture_file.basename.to_s
      }
      @local_file = ActionDispatch::Http::UploadedFile.new(opts)
    end

    it "should refuse files if they are not on the allowed list" do
      expect(Uploader.upload(@local_file, [])).to be_nil
    end

    it "should rename the uploaded file" do
      uploaded_file = Uploader.upload(@local_file, ["text/calendar"])
      expect(uploaded_file.basename.to_s).to match /[\w_=-]*_#{@local_file.original_filename}/
    end
  end

  def clear_uploads_directory
    FileUtils.rm_r(Rails.root.join('public', 'uploads'))
  end
end
