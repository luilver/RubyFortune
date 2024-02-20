task routes: :environment do
  RubyForms::API.routes.each do |route|
    method = route.request_method.ljust(10)
    path = route.origin
    puts "     #{method} #{path}"
  end
end
