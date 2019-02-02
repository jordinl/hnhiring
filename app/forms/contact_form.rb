class ContactForm
  include ActiveModel::Model

  attr_accessor :name, :email, :comments, :phone_number
  validates :name, :email, :comments, presence: true
  validates :email, format: /\A\w+@\w+\.\w+\z/

  def submit?
    valid? && phone_number.blank?
  end
end
