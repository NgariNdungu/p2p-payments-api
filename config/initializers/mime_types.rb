# Be sure to restart your server when you modify this file.

api_mime_types = %W(
    application/vnd.api+json
    text/x-json
    application/json
)
# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Mime::Type.register 'application/vnd.api+json', :json, api_mime_types
