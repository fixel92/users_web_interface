class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :email

  attribute :avatar do |user|
    {
      url: user.avatar.url,
      thumb: user.avatar.thumb.url
    }
  end
end
