class App
  def call(env)

    @request = Rack::Request.new(env)

    if @request.path_info == "/time"
      @time_format = TimeFormat.new(@request.params["format"])
      @time_format.check_formats
      check_time_format(@time_format)
    else
      response("Not found", 404)
    end
  end

  private

  def response(text, status = 200)
    Rack::Response.new(
      text,
      status,
      { 'Content-Type' => 'text/plain' }
    )
  end

  def check_time_format(time)
    if time.errors.empty?
      response("#{time.result}")
    else
      response("Unknown time format #{time.errors}", 400)
    end
  end
end
