pipeline {
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: kaniko
                    image: gcr.io/kaniko-project/executor:debug
                    command:
                    - /busybox/sleep
                    - 99d
                    volumeMounts:
                      - name: kaniko-secret
                        mountPath: /kaniko/.docker
                  volumes:
                    - name: kaniko-secret
                      secret:
                        secretName: docker-credentials
                        items:
                          - key: .dockerconfigjson
                            path: config.json
            '''
        }
    }
    stages {
        stage('Build and Push Docker Image') {
            steps {
                container(name: 'kaniko') {
                    sh '''
                        /kaniko/executor \
                        --context `pwd` \
                        --dockerfile Dockerfile \
                        --destination alejandromons/blog-app:latest \
                        --destination alejandromons/blog-app:$BUILD_NUMBER
                    '''
                }
            }
        }
    }
} 