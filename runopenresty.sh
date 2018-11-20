BASEDIR=$(dirname $(pwd))
sudo docker run --rm -d --name yig-front \
                 -v ${BASEDIR}:/var/log/nginx/ \
                     --net=integrate_vpcbr \
                     --ip 10.5.0.100 \
                 journeymidnight/openresty
