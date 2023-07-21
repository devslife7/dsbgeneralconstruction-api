class ApplicationController < ActionController::API
  def homepage
    render html: "DSP General Construction API is Live"
  end
end
