local host = ngx.req.get_headers()["Host"]
ngx.log(ngx.NOTICE, "HOST=", host)
local subdomain = string.match(host, "(.+).s3%.test%.com")--部署到不同的集群，需要修改对应的域名匹配字段
ngx.log(ngx.NOTICE, "subdomain1=", subdomain)
if subdomain == nil then
        subdomain = string.match(ngx.var.uri, "/(.+)/.+")
        ngx.log(ngx.NOTICE, "subdomain2=", subdomain)
end
if subdomain == "purge" then
        subdomain = "-"
end
ngx.var.bucket_name = subdomain

if ngx.var.request_method == "GET" and ngx.var.request_uri == '/' and subdomain == "" then
	ngx.var.bucket_name = "-"
end
	
