require 'fileutils'

module Uploader
  UPLOAD_DIR = Rails.root.join('public', 'uploads')

  class << self

    def upload(file, allowed_content_types = [])
      return unless allowed_content_types.include?(file.content_type)
      create_uploads_dir
      File.open(Rails.root.join(UPLOAD_DIR, file.original_filename), 'wb') do |f|
        f.write(file.read)
      end
      rename file.original_filename
    end

    protected

      def rename(old_name)
        old = Rails.root.join(UPLOAD_DIR, old_name)
        new = Rails.root.join(UPLOAD_DIR, SecureRandom.urlsafe_base64 + "_" + old_name)
        File.rename(old, new)
        new
      end

      def create_uploads_dir
        FileUtils.mkdir_p(UPLOAD_DIR)
      end
    end
end
