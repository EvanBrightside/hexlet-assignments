# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    return [status, headers, body] if body[0].nil? || status == 404

    hash = Digest::SHA256.hexdigest(body[0])
    new_body = body.push("</br>#{hash}")
    [status, headers, new_body]
  end
end
