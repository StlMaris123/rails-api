Rack::Attack.throttle("req/ip", :limit => 10, :periood => 1.second) do |req|
  req.ip
end
