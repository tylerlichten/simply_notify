require 'spec_helper'

describe SimplyNotify do
  it 'has a version number' do
    expect(SimplyNotify::VERSION).not_to be nil
  end

  it 'should send an email' do
	expect(ActionMailer::Base.deliveries.count).to eq(1)  
  end

  it 'should send email to intended recipient' do
    expect(ActionMailer::Base.deliveries.to).to eq(recipient.email)
  end

  it 'should set subject to the intended subject' do
    expect(ActionMailer::Base.deliveries.subject).to eq(subject)
  end

  it 'should send email from correct email' do 
    expect(ActionMailer::Base.deliveries.from).to eq(Rails.application.config.action_mailer.default_options)
  end

  it 'should set url to homepage if url parameter is nil' do
    if url = nil
    expect(@url).to eq(Rails.application.config.absolute_site_url)
  end

  it 'should set url to source of notification if url parameter is not nil' do
    if url != nil
    expect(@url).to eq(url)
  end

  it 'should track emails for the intended recipient' do
    expect(track user:).to eq(recipient)
  end
end