 docker build -t norothir/multi-client:latest -t norothir/multi-client:$SHA -f ./client/Dockerfile ./client
 docker build -t norothir/multi-server:latest -t norothir/multi-server:$SHA -f ./server/Dockerfile ./server
 docker build -t norothir/multi-worker:latest -t norothir/multi-worker:$SHA -f ./worker/Dockerfile ./worker
 docker push norothir/multi-client:latest
 docker push norothir/multi-server:latest
 docker push norothir/multi-worker:latest

 docker push norothir/multi-client:$SHA 
 docker push norothir/multi-server:$SHA 
 docker push norothir/multi-worker:$SHA 

 kubectl apply -f k8s
 kubectl set image deployments/server-deployments server=norothir/multi-server:$SHA
 kubectl set image deployments/client-deployments client=norothir/multi-client:$SHA
 kubectl set image deployments/worker-deployments worker=norothir/multi-worker:$SHA