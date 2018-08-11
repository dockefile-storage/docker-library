create(){
if [ ! -d $1 ];then
	mkdir -vp  $1
fi
F_NAME=`echo $2| sed 's/:/_/'`
cat <<EOF >$1/$F_NAME 
FROM $3
MAINTAINER Xumin Jiang <cjiangxumin@gmail.com>
EOF
}


# images=(kube-proxy-amd64:v1.11.0
#         kube-scheduler-amd64:v1.11.0
#         kube-controller-manager-amd64:v1.11.0
#         kube-apiserver-amd64:v1.11.0
#         etcd-amd64:3.2.18
#         coredns:1.1.3
#         pause-amd64:3.1
#         pause:3.1
#         kubernetes-dashboard-amd64:v1.8.3
#         k8s-dns-sidecar-amd64:1.14.8
#         k8s-dns-kube-dns-amd64:1.14.8
#         k8s-dns-dnsmasq-nanny-amd64:1.14.8 )
# 

while read line
do
    #echo $line;
    REPO_IMAGE=`echo $line | sed "s/\ //"`
	BASE_NAME=`basename $REPO_IMAGE`
	array=(${BASE_NAME//:/ })
	IMG_NAME=${array[0]}	
	#IMG_VERSION=${array[1]}	

    #echo ${REPO_IMAGE}
    create ${IMG_NAME} ${BASE_NAME}  ${REPO_IMAGE}

done < ./images.list

# git add .
# git commit -m "...."
# git pull origin master

