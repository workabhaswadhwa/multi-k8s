#Build all docker images
docker build -t workabhaswadhwa/mulit-client:latest -t workabhaswadhwa/mulit-client:$SHA -f ./client/Dockerfile ./client
docker build -t workabhaswadhwa/mulit-server:latest -t workabhaswadhwa/mulit-server:$SHA -f ./server/Dockerfile ./server
docker build -t workabhaswadhwa/mulit-worker:latest -t workabhaswadhwa/mulit-worker:$SHA -f ./worker/Dockerfile ./worker

#Push images to dockerhub
docker push workabhaswadhwa/mulit-client:latest
docker push workabhaswadhwa/mulit-server:latest
docker push workabhaswadhwa/mulit-worker:latest

docker push workabhaswadhwa/mulit-client:$SHA
docker push workabhaswadhwa/mulit-server:$SHA
docker push workabhaswadhwa/mulit-worker:$SHA

#apply K8 configs
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=workabhaswadhwa/mulit-server:$SHA
kubectl set image deployments/client-deployment client=workabhaswadhwa/mulit-client:$SHA
kubectl set image deployments/worker-deployment worker=workabhaswadhwa/mulit-worker:$SHA