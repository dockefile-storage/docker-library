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

REGISTRY_ALIYUNCS=registry.cn-hangzhou.aliyuncs.com
NAME_SPACE=k8s-gcr-io-jxm

pull_and_rename()
{
	echo "docker pull ${REGISTRY_ALIYUNCS}/${NAME_SPACE}/$1"
	docker pull ${REGISTRY_ALIYUNCS}/${NAME_SPACE}/$1

	echo "docker tag  ${REGISTRY_ALIYUNCS}/${NAME_SPACE}/$1 $2"
	docker tag  ${REGISTRY_ALIYUNCS}/${NAME_SPACE}/$1 $2

	echo "docker rmi  ${REGISTRY_ALIYUNCS}/${NAME_SPACE}/$1"
	docker rmi  ${REGISTRY_ALIYUNCS}/${NAME_SPACE}/$1
}

create(){
if [ ! -d $1 ];then
	mkdir -vp  $1
fi
cat <<EOF >$1/$1_$2 
FROM gcr.io/google_containers/$1:$2
MAINTAINER Xumin Jiang <cjiangxumin@gmail.com>
EOF
}

while read line
do
    #echo $line;
    REPO_IMAGE=`echo $line | sed "s/\ //"`
    BASE_NAME=`basename $REPO_IMAGE`
	echo $imageName
	pull_and_rename $BASE_NAME $REPO_IMAGE 

done < ./images.list

# REGISTRY_ALIYUNCS=registry.cn-hangzhou.aliyuncs.com
# NAME_SPACE=k8s-gcr-io-jxm
# for imageName in ${images[@]} ; do
#    pull_and_rename $imageName
#done

# git add .
# git commit -m "...."
# git pull origin master

