class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  before_validation :generate_jti, on: :create

  validates :name, presence: true, length: { minimum: 2, maximum: 35 }
  validates :jti, presence: true

  mount_uploader :avatar, AvatarUploader

  private

  def generate_jti
    self.jti = SecureRandom.uuid
  end
end
