require "rails/generators"
require "thor"

class NotifierGenerator < Rails::Generators::Base
  desc "This generator creates the Model and Views"

  def create_model_file
  	create_file "models/notifier.rb", "require 'simply_notify'"
  end 

  def create_html_view_file
    create_file "views/notifier/html.html.erb", "# Put html here"
  end

  def create_text_view_file
    create_file "views/notifier/text.html.erb", "# Put text here"
  end
end
