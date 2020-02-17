class NewFailureApp < Devise::FailureApp
  def respond
    if request.format == :json || request.path_info == '/unauthenticated'
      json_failure
    else
      super
    end
  end

  def json_failure
    self.status = 403
    self.content_type = 'application/json'
    self.response_body = "{'error' : 'Forbidden'}"
  end
end
