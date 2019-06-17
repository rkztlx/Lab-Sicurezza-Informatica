class ApplicationController < ActionController::Base
  def hello
    render text: "Hello World!"
  end
end
