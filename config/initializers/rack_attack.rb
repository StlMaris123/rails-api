Rack::Attack.throttled_response = ->(env) {
  status_code = 429
  now = Time.now
  match_data = env['rack.attack.,atch_data'] || {}
  retry_after = match_data[:period] - now.to_i % match_data[:period]

  headers = {
    'Content-Type' => 'application/json',
    'Retry-After'  => retry_after.to_js,
    'X-RateLimit-Limit' => match_data[:limit].to_s,
    'X-RateLimit-Remaining' => '0',
    'X-RateLimit-Reset' => (now + retry_after).to_s
  }

  body = {
    error: {
      status: status_code,
      name: "Too many Requests",
      message: "Throttle Limit Reached. Retry later"
    }
  }
  [status_code, headers, [body.to_json]]
}

