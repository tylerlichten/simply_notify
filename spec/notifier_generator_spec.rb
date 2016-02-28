require 'spec_helper_generator'
require 'generator_spec'

describe NotifierGenerator, type: :generator do
  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates Model" do
    assert_file "model/notifier.rb", "require 'simply_notify'"
  end

  it "creates View for html" do
    assert_file "views/notifier/html.html.erb", "# Put html here"
  end

  it "creates View for text" do
    assert_file "views/notifier/text.html.erb", "# Put text here"
  end
end