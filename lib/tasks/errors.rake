namespace :errors do
  desc "Precompile error pages into public directory"
  task precompile: [:environment] do
    [500].each do |status|
      request = Rack::MockRequest.new(ErrorsController.action(status))
      response = request.get("/#{status}")
      path = File.join(Rails.application.paths["public"].first, "#{status}.html")
      File.write(path, response.body)
    end
  end
end
