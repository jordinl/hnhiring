class ContactsController < ApplicationController
  def show
    @form = ContactForm.new
  end

  def create
    @form = ContactForm.new(params.require(:contact).permit(:name, :email, :comments, :phone_number))
    if @form.valid?
      ContactMailer.contact(@form).deliver if @form.submit?
      redirect_to root_path, flash: { success: "Thanks for reaching out! I'll get back to you as soon as I can." }
    else
      render :show
    end
  end
end
