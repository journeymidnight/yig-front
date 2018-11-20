listen {
  port = 4040
}

consul {
  enable = false
  address = "localhost:8500"
  datacenter = "dc1"
  scheme = "http"
  token = ""
  service {
    id = "nginx-exporter"
    name = "nginx-exporter"
    tags = ["foo", "bar"]
  }
}

namespace "nginx" {
  source_files = [
    "/var/log/nginx/access.log"
  ]
  format = "\"$bucket_name\" \"$host\" \"$remote_addr\" \"$http_x_real_ip\" \"-\" \"-\" \"[$time_local]\"  \"$status\" \"$body_bytes_sent\" \"$http_referer\" \"$http_user_agent\" \"$request\" \"$request_length\" \"$request_time\" \"$upstream_response_time\" \"$sent_http_content_type\" \"$upstream_cache_status\""


 relabel "bucket_name" {
   from = "bucket_name"
   // whitelist = ["-", "user1", "user2"]
 }
}
