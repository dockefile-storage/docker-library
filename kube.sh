create(){
if [ ! -d $1 ];then
	mkdir -vp  $1
fi

cat <<EOF >$1/$1:$2 
FROM gcr.io/google_containers/$1:$2
MAINTAINER Xumin Jiang <cjiangxumin@gmail.com>
EOF
}


images=(kube-proxy-amd64:v1.11.0
        kube-scheduler-amd64:v1.11.0
        kube-controller-manager-amd64:v1.11.0
        kube-apiserver-amd64:v1.11.0
        etcd-amd64:3.2.18
        coredns:1.1.3
        pause-amd64:3.1
        kubernetes-dashboard-amd64:v1.8.3
        k8s-dns-sidecar-amd64:1.14.8
        k8s-dns-kube-dns-amd64:1.14.8
        k8s-dns-dnsmasq-nanny-amd64:1.14.8 )

for imageName in ${images[@]} ; do
	array=(${imageName//:/ })
	IMG_NAME=${array[0]}	
	IMG_VERSION=${array[1]}	
	IMG_VERSION=${array[1]}	
    echo ${IMG_NAME} : ${IMG_VERSION}
    create ${IMG_NAME} ${IMG_VERSION}
done

#for imageName in ${images[@]} ; do
#docker pull registry.cn-shenzhen.aliyuncs.com/duyj/$imageName
#docker tag registry.cn-shenzhen.aliyuncs.com/duyj/$imageName k8s.gcr.io/$imageName
#docker rmi registry.cn-shenzhen.aliyuncs.com/duyj/$imageName
#done
