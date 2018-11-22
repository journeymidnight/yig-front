FROM centos:7.2.1511
ENV GOPATH="/root/go"

COPY . /work
WORKDIR /work
RUN yum install yum-utils -y && yum-config-manager --add-repo https://openresty.org/yum/cn/centos/OpenResty.repo && yum install -y openresty && cp -f nginx.conf /usr/local/openresty/nginx/conf/ && mkdir /usr/local/openresty/nginx/conf/lua && cp bucket.lua /usr/local/openresty/nginx/conf/lua/ && mkdir -p /var/log/nginx/
RUN rpm --rebuilddb && yum install golang git -y && go get github.com/journeymidnight/prometheus-nginxlog-exporter && cd $GOPATH/src/github.com/journeymidnight/prometheus-nginxlog-exporter && go build && cp prometheus-nginxlog-exporter /work

CMD ["/work/start_front.sh"]
