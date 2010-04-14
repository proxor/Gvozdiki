class OrderMailer < ActionMailer::Base
  

  def sent(order, sent_at = Time.now)
    @subject    = 'OrderMailer#sent'
    @recipients = 'p@shuchalov.ru'
    @sent_on    = sent_at
    
    @body[:order] = order
  end

end
