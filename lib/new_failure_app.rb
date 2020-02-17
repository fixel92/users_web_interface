class NewFailureApp < Devise::FailureApp
  def respond
    if request.format == :json || params['controller'] == 'api/v1/'
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
