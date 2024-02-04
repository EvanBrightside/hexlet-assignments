# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, body = @app.call(env)
    return [status, headers, body] if body[0].nil? || status == 404

    time_taken = (1000 * (Time.now - start_time))
    [status, headers, body.push("</br>#{time_taken}")]
  end
end
