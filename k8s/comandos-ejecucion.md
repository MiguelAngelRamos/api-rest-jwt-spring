# Guía de ejecución para desplegar la API en Kubernetes

## 1. Crear el namespace
```powershell
kubectl apply -f k8s/00-namespace.yaml
```

## 2. Aplicar los recursos en el namespace (en orden)
```powershell
kubectl apply -f k8s/01-pv-pvc-postgres.yaml -n api-rest-jwt-spring
kubectl apply -f k8s/02-postgres-deployment.yaml -n api-rest-jwt-spring
kubectl apply -f k8s/03-postgres-service.yaml -n api-rest-jwt-spring
kubectl apply -f k8s/04-api-deployment.yaml -n api-rest-jwt-spring
kubectl apply -f k8s/05-api-service.yaml -n api-rest-jwt-spring
kubectl apply -f k8s/06-api-hpa.yaml -n api-rest-jwt-spring
kubectl apply -f k8s/07-api-loadbalancer.yaml -n api-rest-jwt-spring
```

## 3. Verificar los recursos
```powershell
kubectl get all -n api-rest-jwt-spring
```

## 4. Habilitar el túnel de Minikube (solo si usas Minikube)
> **Nota:** El Service de tipo LoadBalancer requiere un túnel para exponer la IP externa en entornos locales como Minikube.
```powershell
minikube tunnel
```
Mantén esta terminal abierta mientras el túnel esté activo.

## 5. Obtener la IP externa del LoadBalancer
```powershell
kubectl get svc api-loadbalancer -n api-rest-jwt-spring
```

## 6. Consultar la API desde Postman
- Usa la IP externa (por ejemplo, `127.0.0.1`) y el puerto 80:
  ```
  http://127.0.0.1/api/clientes
  ```
- Para registrar un usuario (POST):
  ```
  POST http://127.0.0.1/api/usuarios/registro
  Content-Type: application/json
  {
    "username": "catalina",
    "password": "academy",
    "email": "catalina@correo.com"
  }
  ```
- Si tu API requiere autenticación JWT, agrega el header:
  ```
  Authorization: Bearer <tu_token_jwt>
  ```

---

## Alternativa: Port-forward
Si el LoadBalancer no es accesible, puedes usar port-forward:
```powershell
kubectl port-forward svc/api-service 8080:80 -n api-rest-jwt-spring
```
Luego accede a:
```
http://127.0.0.1:8080/api/clientes
http://127.0.0.1:8080/api/usuarios/registro
```