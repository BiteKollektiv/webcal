# The secret token is empty for external pull requests on travis.
# || "A" * 20 seems like a lazy workaround. Would be nice to make this better.
Webcal::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || "A" * 20
