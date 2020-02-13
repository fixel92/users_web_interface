class UserSerializer
  include FastJsonapi::ObjectSerializer

  attribute :name, :avatar, :email
end
