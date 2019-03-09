#!/bin/bash

kubectl run nginx --image=nginx --replicas=3 --port=80

kubectl autoscale deployment "nginx" --cpu-percent=50 --min=1 --max=10

kubectl expose deployment nginx --type="LoadBalancer"
