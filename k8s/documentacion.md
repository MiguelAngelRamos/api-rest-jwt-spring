# HPA y Load Balancer en Kubernetes

## Horizontal Pod Autoscaler (HPA)
El HPA es un recurso de Kubernetes que ajusta automáticamente el número de pods de un Deployment, ReplicaSet o StatefulSet según métricas como el uso de CPU o memoria. Por ejemplo, si la carga aumenta, el HPA puede crear más pods para manejar el tráfico.

**Ejemplo de HPA:**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api-deployment
  minReplicas: 1
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```

## Load Balancer
Un Service de tipo LoadBalancer expone la aplicación a internet y distribuye el tráfico entrante entre los pods disponibles. Esto asegura alta disponibilidad y balanceo de carga.

**Ejemplo de Service LoadBalancer:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: api-loadbalancer
spec:
  selector:
    app: api
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: LoadBalancer
```

## Relación entre HPA y Load Balancer
- El Load Balancer reparte el tráfico entre los pods disponibles.
- El HPA ajusta la cantidad de pods según la demanda.
- Juntos permiten que la aplicación escale automáticamente y mantenga la disponibilidad ante picos de tráfico.

## Resumen
- Usa HPA para escalar horizontalmente los pods.
- Usa LoadBalancer para distribuir el tráfico entre los pods.
- Ambos recursos se complementan para lograr escalabilidad y alta disponibilidad en Kubernetes.
