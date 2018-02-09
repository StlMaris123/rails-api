class BaseController < ApplicationController
  include JSONAPI::ErrorRendering
  prepend JSONAPI::Rendering

  before_action :doorkeeper_authorize!

  def doorkeeper_unauthorized_render_options(error: nil)
    message = 'Not authorized to perform requested action'
    if error && error.respond_to?(:description)
      message = error.description
    end
    {
      status: :unauthorized,
      json: {
        error: {
          status: 401,
          name: 'unauthorized',
          message: message
        }

      }
    }
  end
end
