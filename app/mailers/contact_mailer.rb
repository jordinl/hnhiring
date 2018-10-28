class ContactMailer < ActionMailer::Base
  default to: 'jordi@hnhiring.com'
  layout false

  def contact(form)
    subject = "#{form.name} sent you a message on HNHIRING"
    from = "#{form.name} via HNHIRING <jordi@hnhiring.com>"
    @comments = form.comments

    mail(subject: subject, from: from, reply_to: form.email)
  end
end
