# Author - Nate V
# Initializes a render for the CSV mime type
# CSV renderer taken from Stack Overflow
# https://stackoverflow.com/questions/5182344/rails-3-how-to-respond-with-csv-without-having-a-template-file
ActionController::Renderers.add :csv do |obj, options|
  filename = options[:filename] || 'data'
  str = obj.respond_to?(:to_csv) ? obj.to_csv : obj.to_s
  send_data str, :type => Mime::CSV,
    :disposition => "attachment; filename=#{filename}.csv"
end