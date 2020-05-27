docker build -t lstas180877/multi-client:latest -t lstas180877/multi-client:$SHA  -f ./client/Dockerfile.dev ./client
docker build -t lstas180877/multi-server:latest -t lstas180877/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t lstas180877/multi-worker:latest -t lstas180877/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push lstas180877/multi-client:latest
docker push lstas180877/multi-server:latest
docker push lstas180877/multi-worker:latest
docker push lstas180877/multi-client:$SHA
docker push lstas180877/multi-server:$SHA
docker push lstas180877/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lstas180877/multi-server:$SHA
kubectl set image deployments/client-deployment server=lstas180877/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lstas180877/multi-worker:$SHA
