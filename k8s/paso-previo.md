✅ Miguel, tu salida:

```bash
miguel@ServerUbuntuK8:~/jwt-spring/api-rest-jwt-spring/k8$ kubectl get pods -n kube-system | grep metrics-server
miguel@ServerUbuntuK8:~/jwt-spring/api-rest-jwt-spring/k8$ 
```

📌 Esto significa que **no hay ningún pod con nombre `metrics-server` corriendo actualmente en el namespace `kube-system`**.

---

### 🔷 ¿Qué hacer ahora?

Instalarlo.

### 📋 Comando para instalar `metrics-server`:

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

Después espera unos segundos y vuelve a comprobar:

```bash
kubectl get pods -n kube-system | grep metrics-server
```

Cuando esté listo, verás algo como:

```
metrics-server-6f6cdbf67d-vl2pl   1/1     Running   0          30s
```

Y ya puedes probar:

```bash
kubectl top nodes
kubectl top pods
```

---

Si quieres, también te puedo dar un pequeño **script completo** que:
✅ Verifica si está instalado
✅ Si no está, lo instala
✅ Y espera a que esté en estado `Running`

¿Te lo preparo? 🚀
