class ContactForm
  include ActiveModel::Model

  attr_accessor :name, :email, :comments
  validates :name, :email, :comments, presence: true
  validates :email, format: /\A\w+@\w+\.\w+\z/
end
