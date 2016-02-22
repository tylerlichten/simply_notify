require 'spec_helper'

describe SimplyNotify do
  it 'has a version number' do
    expect(SimplyNotify::VERSION).not_to be nil
  end

  it 'should send an email' do
	expect(ActionMailer::Base.deliveries.count).to eq(1)  
  end

  it 'should send email to correct recipient' do
    expect(ActionMailer::Base.deliveries.to).to eq(@recipient.email)
  end

  it 'should set subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.subject).to eq('New Notification')
  end

  it 'should send email from correct email' do 
    expect(ActionMailer::Base.deliveries.from).to eq('no-reply@brandeis.edu')
  end
end

