docker build -t hpompecki/multi-client:latest -t hpompecki/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hpompecki/multi-server:latest -t hpompecki/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hpompecki/multi-worker:latest -t hpompecki/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hpompecki/multi-client:latest
docker push hpompecki/multi-client:$SHA
docker push hpompecki/multi-server:latest
docker push hpompecki/multi-server:$SHA
docker push hpompecki/multi-worker:latest
docker push hpompecki/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=hpompecki/multi-client:$SHA
kubectl set image deployments/server-deployment server=hpompecki/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hpompecki/multi-worker:$SHA
