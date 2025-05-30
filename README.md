# Jenkins en Minikube con Kaniko

Este proyecto implementa un pipeline de CI/CD usando Jenkins en Minikube con Kaniko para construir y publicar imágenes Docker.

## Requisitos Previos

- Minikube instalado
- kubectl instalado
- Docker instalado
- Git instalado

## Pasos de Implementación

1. Iniciar Minikube:
```bash
minikube start
```

2. Crear el secreto de Docker Hub:
```bash
chmod +x create-docker-secret.sh
./create-docker-secret.sh
```

3. Aplicar los manifiestos de Kubernetes:
```bash
kubectl apply -f jenkins-sa-crb.yaml
kubectl apply -f jenkins-pvc.yaml
kubectl apply -f jenkins-svc.yaml
kubectl apply -f jenkins-deployment.yaml
```

4. Obtener la URL de Jenkins:
```bash
minikube service jenkins-service --url
```

5. Obtener la contraseña inicial de Jenkins:
```bash
kubectl exec -it $(kubectl get pods -l app=jenkins -o jsonpath='{.items[0].metadata.name}') -- cat /run/secrets/additional/chart-admin-password
```

6. Configurar Jenkins:
   - Acceder a la URL de Jenkins
   - Instalar los plugins sugeridos
   - Configurar las credenciales de Docker Hub
   - Crear un nuevo pipeline usando el Jenkinsfile

## Estructura del Proyecto

- `Jenkinsfile`: Define el pipeline de CI/CD
- `Dockerfile`: Define la imagen de la aplicación
- `jenkins-deployment.yaml`: Despliegue de Jenkins
- `jenkins-svc.yaml`: Servicio de Jenkins
- `jenkins-pvc.yaml`: Persistencia de datos
- `jenkins-sa-crb.yaml`: Roles y permisos
- `create-docker-secret.sh`: Script para crear el secreto de Docker Hub

## Verificación

1. Verificar que Jenkins está corriendo:
```bash
kubectl get pods -l app=jenkins
```

2. Verificar el servicio:
```bash
kubectl get svc jenkins-service
```

3. Verificar los logs de Jenkins:
```bash
kubectl logs -l app=jenkins
```

## Notas Importantes

- Las credenciales de Docker Hub están configuradas en el secreto `docker-credentials`
- El pipeline construye y publica la imagen en Docker Hub bajo el usuario `alejandromons`
- La imagen se publica con dos tags: `latest` y el número de build 