require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Flashcards
  class Application < Rails::Application
# Settings in config/environments/* take precedence over those specified here.
# Application configuration should go into files in config/initializers
# -- all .rb files in that directory are automatically loaded.

# Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
# Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
# config.time_zone = 'Central Time (US & Canada)'

# The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
# config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

# Do not swallow errors in after_commit/after_rollback callbacks.

    ActionView::Base.field_error_proc = Proc.new do |html_tag|
      class_attr_index = html_tag.index 'class="'

      if class_attr_index
        html_tag.insert class_attr_index + 7, 'error '
      else
        html_tag.insert html_tag.index('>'), ' class="error"'
      end
    end

    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(#{config.root}/lib)
    config.paperclip_defaults = {
      storage: :s3,
      s3_host_name: "s3.eu-central-1.amazonaws.com",
      s3_credentials: {
        bucket: ENV["S3_BUCKET_NAME"],
        access_key_id: ENV["AWS_ACCESS_KEY_ID"],
        secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
      },
      url: ":s3_path_url",
      path: "/:class/:attachment/:id_partition/:style/:filename"
    }
  end
end
