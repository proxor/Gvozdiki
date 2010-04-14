require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  tests OrderMailer
  def test_confirm
    @expected.subject = 'OrderMailer#confirm'
    @expected.body    = read_fixture('confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, OrderMailer.create_confirm(@expected.date).encoded
  end

  def test_sent
    @expected.subject = 'OrderMailer#sent'
    @expected.body    = read_fixture('sent')
    @expected.date    = Time.now

    assert_equal @expected.encoded, OrderMailer.create_sent(@expected.date).encoded
  end

end
