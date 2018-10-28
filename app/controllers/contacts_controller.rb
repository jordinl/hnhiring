class ContactsController < ApplicationController
  def show
    @form = ContactForm.new
  end

  def create
    @form = ContactForm.new(params.require(:contact).permit(:name, :email, :comments))
    if @form.valid?
      ContactMailer.contact(@form).deliver
      redirect_to root_path, flash: { success: "Thanks for reaching out! I'll get back to you as soon as I can." }
    else
      render :show
    end
  end
end
