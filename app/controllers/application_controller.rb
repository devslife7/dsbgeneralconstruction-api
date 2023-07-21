class ApplicationController < ActionController::API
  def homepage
    render html: "ProTaskr API Live"
  end
end
