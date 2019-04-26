JSONAPI.configure do |config|
  config.raise_if_parameters_not_allowed = true
  config.json_key_format = :underscored_key
end
