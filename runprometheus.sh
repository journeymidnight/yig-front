BASEDIR=$(pwd)
sudo docker run  --name prometheus \
		 -p 9090:9090 \
                 -v ${BASEDIR}/prometheus.yml:/etc/prometheus/prometheus.yml \
                 --net=integrate_vpcbr \
                 --ip 10.5.0.101 \
                 prom/prometheus:v2.5.0 --storage.tsdb.retention=3y --config.file=/etc/prometheus/prometheus.yml

