BASEDIR=$(pwd)
sudo docker run --rm -d --name yig-front \
		 -p 4040:4040 \
                 -v ${BASEDIR}:/var/log/nginx/ \
                 --net=integrate_vpcbr \
                 --ip 10.5.0.100 \
                 journeymidnight/yig-front
