require "rack"
require "rails-html-sanitizer"

app = lambda do |env|
  req = Rack::Request.new(env)

  case [req.request_method, req.path_info]
  when ["GET", "/"]
    next_url = req.params["next"].to_s
    next_url = "java&#13;script:document.title='owned';document.body.innerText='EXECUTED';void(0)" if next_url.empty?
    allowed = Rails::HTML::Sanitizer.allowed_uri?(next_url)

    body = <<~HTML
      <!doctype html>
      <html>
        <head>
          <meta charset="utf-8">
          <title>allowed-uri-e2e</title>
        </head>
        <body>
          <h1>Continue</h1>
          <pre id="meta">allowed=#{allowed.inspect}\nnext=#{next_url.inspect}</pre>
          #{allowed ? %(<a id="continue" href="#{next_url}">Continue</a>) : %(<p id="blocked">Blocked</p>)}
        </body>
      </html>
    HTML

    [200, { "content-type" => "text/html; charset=utf-8" }, [body]]
  else
    [404, { "content-type" => "text/plain; charset=utf-8" }, ["not found"]]
  end
end

run app