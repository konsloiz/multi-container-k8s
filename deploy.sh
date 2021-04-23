docker build -t konsloiz/multi-client:latest -t konsloiz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t konsloiz/multi-server:latest -t konsloiz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t konsloiz/multi-worker:latest -t konsloiz/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push konsloiz/multi-client:latest
docker push konsloiz/multi-server:latest
docker push konsloiz/multi-worker:latest

docker push konsloiz/multi-client:$SHA
docker push konsloiz/multi-server:$SHA
docker push konsloiz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=konsloiz/multi-client:$SHA
kubectl set image deployments/server-deployment server=konsloiz/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=konsloiz/multi-worker:$SHA
