
# 对象存储流量接口说明
## API
###	获取流量

#### 请求


请求URL格式：GET  http://{IP:Port}/api/v1/query?query=increase(nginx_http_response_size_bytes{bucket_name=”{bucket_name}”,method=”GET”}[{time_interval}])&time={time}

例如：
获取北京时间2018年11月19日 15：30：00到15：35：00之间，名为“abc”的bucket的总流量：
http://111.166.23.117:9090/api/v1/query?query=increase(nginx_http_response_size_bytes{bucket_name="abc",method="GET"}[5m])&time=2018-11-19T07:35:00.00Z


##### 参数说明
```
IP:Port	   服务所在的IP和端口
bucket_name	想要查询的bucket名称
time_inteval	查询的时间间隔
time	查询的最后时间点，遵循RFC3339格式或unix时间戳
```

#### 响应
API返回值的格式是JSON，每一个成功的API请求都会返回2xx的状态码
返回值类似下列格式：
```shell
{
  "status": "success" | "error",
  "data": <data>,
  // 只有status为error的时候才有errorType
  "errorType": "<string>",
  "error": "<string>"
}
```




###	获取IOPS

#### 请求
请求URL格式：GET http://{IP:Port}/api/v1/query?query=rate(nginx_http_response_count_total{bucket_name=”{bucket_name}”,method=”GET”}[{time_interval}])&time={time}

例如：
获取北京时间2018年11月19日 15：34：00到15：35：00之间，名为abc的bucket的平均请求速率
http://111.166.23.117:9090/api/v1/query?query=rate(nginx_http_response_count_total{bucket_name="abc",method="GET"}[1m])&time=2018-11-19T07:35:00.00Z
##### 参数说明
```
IP:Port	   服务所在的IP和端口
bucket_name	想要查询的bucket名称
time_inteval	查询的时间间隔
time	查询的最后时间点，遵循RFC3339格式或unix时间戳
```


#### 响应
API返回值的格式是JSON，每一个成功的API请求都会返回2xx的状态码
返回值类似下列格式：
```shell
{
  "status": "success" | "error",
  "data": <data>,
  // 只有status为error的时候才有errorType
  "errorType": "<string>",
  "error": "<string>"
}
```

###	获取bucket使用量

#### 请求
请求URL格式：GET http://{IP:Port}/api/v1/query_range?query=yig_bucket_usage_byte_metric{bucket_name=”{bucket_name}”}&start=2018-12-10T07:35:00.00Z&end=2018-12-12T15:35:00.00Z&step=60

例如：
获取北京时间2018-12-10T07:35:00.00Z到2018-12-12T15:35:00.00Z之间，名为test的bucket的使用量，输入点时间间隔60秒
http://10.0.6.54:9090/api/v1/query_range?query=yig_bucket_usage_byte_metric{bucket=%22test%22}&start=2018-12-10T07:35:00.00Z&end=2018-12-12T15:35:00.00Z&step=60
##### 参数说明
```
IP:Port	   服务所在的IP和端口
bucket	想要查询的bucket名称
step	查询的时间间隔(s)
time	查询的最后时间点，遵循RFC3339格式或unix时间戳
```


#### 响应
API返回值的格式是JSON，每一个成功的API请求都会返回2xx的状态码
返回值类似下列格式：
```shell
{
  "status": "success" | "error",
  "data": <data>,
  // 只有status为error的时候才有errorType
  "errorType": "<string>",
  "error": "<string>"
}
```




## 演示代码
### golang
```shell
package main

import (
        "fmt"
        "io/ioutil"
        "net/http"
        "net/url"
)

var IP string = "111.166.23.117"
var Port string = "9090"
var Bucket string = "abc"

func main() {
        fetchBytes()
        fetchIOPS()
}

func fetchBytes() {
        interval := "[5m]"
        express:= fmt.Sprintf("nginx_http_response_size_bytes{bucket_name=\"%s\",method=\"GET\"}%s", Bucket, interval)
        req := fmt.Sprintf("http://%s:%s/api/v1/query?query=increase(%s)&time=2018-11-19T07:35:00.00Z", IP, Port, url.QueryEscape(express))
        fmt.Println("The origin url for fetchBytes is:", req)
        res, err := http.Get(req)
        body, err := ioutil.ReadAll(res.Body)
        fmt.Println("result is:")
        fmt.Println(string(body), err)
}

func fetchIOPS() {
        interval := "[5m]"
        express := fmt.Sprintf("nginx_http_response_count_total{bucket_name=\"%s\",method=\"GET\"}%s", Bucket, interval)
        req := fmt.Sprintf("http://%s:%s/api/v1/query?query=rate(%s)&time=2018-11-19T07:35:00.00Z", IP, Port, url.QueryEscape(express))
        fmt.Println("The origin url for fetchBytes is:", req)
        res, err := http.Get(req)
        body, err := ioutil.ReadAll(res.Body)
        fmt.Println("result is:")
        fmt.Println(string(body), err)
}
```