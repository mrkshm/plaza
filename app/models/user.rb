class User < ApplicationRecord
  include Authentication
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  validates :name, presence: true
  validates :email, presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }

  normalizes :name, with: ->(name) { name.strip }
  normalizes :email, with: ->(email) { email.strip.downcase }
  def self.create_app_session(email:, password:)
    user = User.authenticate_by(email: email, password: password)
    user.app_sessions.create if user.present?
  end
end
