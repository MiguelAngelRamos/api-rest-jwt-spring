✅ Muy bien, Miguel, ya diste el primer paso: instalaste el `metrics-server` y su pod está en estado **Running**. Eso ya es correcto.

Pero aún ves el error:

```
error: Metrics API not available
```

Esto ocurre bastante en **Minikube**, y casi siempre se debe a uno de estos motivos típicos:

---

# 📋 Razones frecuentes

1️⃣ 🔷 El `metrics-server` necesita que el clúster acepte certificados inseguros o sin verificación del hostname.
En un clúster de laboratorio (como Minikube) esto es normal.

2️⃣ 🔷 El addon de `metrics-server` de Minikube ya viene preparado con esas opciones, y es más fácil activarlo así.

---

# 🚀 Solución recomendada en Minikube

En lugar de aplicar el YAML oficial, puedes usar el addon nativo de Minikube:

### 1️⃣ Desinstala lo que aplicaste:

```bash
kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### 2️⃣ Activa el addon de Minikube:

```bash
minikube addons enable metrics-server
```

### 3️⃣ Verifica que esté corriendo:

```bash
kubectl get pods -n kube-system | grep metrics-server
```

Cuando ya esté en `Running`, espera unos 10–20 segundos y prueba:

```bash
kubectl top nodes
kubectl top pods
```

---

# 📑 Si no quieres eliminar lo que aplicaste:

También puedes **editar el Deployment del metrics-server** que ya instalaste y agregarle estos argumentos al container para ignorar la validación TLS:

```bash
kubectl edit deployment metrics-server -n kube-system
```

Y en `spec.template.spec.containers.args` agrega:

```yaml
- --kubelet-insecure-tls
- --kubelet-preferred-address-types=InternalIP
```

Guarda y espera a que el pod se reinicie. Luego prueba de nuevo.

---

# 👌 Resumen:

✅ En Minikube lo más simple es usar:

```bash
minikube addons enable metrics-server
```

Pero si prefieres mantener el YAML oficial, edita el deployment y añade los argumentos.

---

Si quieres, te puedo preparar el comando exacto para editarlo con `kubectl patch` (sin abrir el editor) y que quede listo directamente.
¿Te lo preparo? 🚀
