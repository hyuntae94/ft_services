//퍼시스턴트볼륨클레임

- https://kubernetes.io/ko/docs/reference/glossary/?fundamental=true ->용어집
-------------------------------------------------------------------------------
- Minikube는 가벼운 쿠버네티스 구현체이며, 로컬 머신에 VM을 만들고 하나의 노드로 구성된 간단한 클러스터를 생성한다. Minikube는 리눅스, 맥, 그리고 윈도우 시스템에서 구동이 가능하다. Minikube CLI는 클러스터에 대해 시작, 중지, 상태 조회 및 삭제 등의 기본적인 부트스트래핑(bootstrapping) 기능을 제공한다.
- minikube start --driver=virtualbox(virtualbox로 실행하기)
- minikube dashboard -> 대시보드 열기
- minikube status -> 상태확인
- minikube ip -> ip확인
- minikube stop -> 종료
- minikube delete -> 삭제
-------------------------------------------------------------------------------
- Kubectl은 쿠버네티스 클러스터를 제어하기 위한 커맨드 라인 도구이다. 
- kubectl [command] [TYPE] [NAME] [flags]
- command: 하나 이상의 리소스에서 수행하려는 동작을 지정한다. 예: create, get, describe, delete
ex) kubectl delete service hello-node(hello-node 라는 서비스 삭제)
ex) kubectl delete deploy hello-node(hello-node 라는 디플로먼트 삭제)
- TYPE
1)pods(po)
kubectl get pod(type) pod1(name)
kubectl get pods(type) pod1(name)
kubectl get po(type) pod1(name)
2)configmaps(cm)
3)endpoints(ep)
4)persistenVolumeClaims(pvc)
5)secrets
6)services(svc)
7)deployments(deploy)
8)replicasets(rs)
- NAME: 리소스 이름을 지정한다. 이름은 대소문자를 구분한다. 이름을 생략하면, 모든 리소스에 대한 세부 사항이 표시된다
- flags: 선택적 플래그를 지정한다. 예를 들어, -s 또는 --server 플래그를 사용하여 쿠버네티스 API 서버의 주소와 포트를 지정할 수 있다.  ex) --type=LoadBalancer(클러스터 밖의 서비스로 노출), --port=8080
- minikube에서 LoadBalancer타입은 minikube service 명령어를 통해서 해당 서비스 접근 가능
- minikube addons list : 애드온 목록 확인
ex) minikube addons enable [NAME] -> 활성화
ex) minikube addons disable [NAME] -> 비활성화

-------------------------------------------------------------------------------
- 디플로이먼트는 쿠버네티스가 애플리케이션의 인스턴스를 어떻게 생성하고 업데이트해야 하는지를 지시. 디플로이먼트가 만들어 지면,
쿠버네티스 컨트롤 플레인이 해당 디플로이먼트에 포함된 애플리케이션 인스턴스가 개별노드에 실행되도록 스케줄. 애플리케이션 인스턴스가 생성되면, 쿠버네티스 디플로이먼트 컨트롤러는 지속적으로 이들 인스턴스를 모니터링한다.인스턴스를 구동 중인 노드가 다운되거나 삭제되면, 디플로이먼트 컨트롤러가 인스턴스를 클러스터 내부의 다른 노드의 인스턴스로 교체시켜준다.이렇게 머신의 장애나 정비에 대응할 수 있는 자동 복구(self-healing) 메커니즘을 제공한다.
- https://d33wubrfki0l68.cloudfront.net/8700a7f5f0008913aa6c25a1b26c08461e4947c7/cfc2c/docs/tutorials/kubernetes-basics/public/images/module_02_first_app.svg
- Kubectl이라는 쿠버네티스 CLI를 통해 디플로이먼트를 생성(kubectl apply)하고 관리할 수 있다.
- Kubectl은 클러스터와 상호 작용하기 위해 쿠버네티스 API를 사용한다.

-------------------------------------------------------------------------------
- 파드(https://d33wubrfki0l68.cloudfront.net/fe03f68d8ede9815184852ca2a4fd30325e5d15a/98064/docs/tutorials/kubernetes-basics/public/images/module_03_pods.svg)

-------------------------------------------------------------------------------
- 파드는 언제나 노드 상에서 동작한다.
- 노드는 쿠버네티스에서 워커 머신을 말하며 클러스터에 따라 가상 또는 물리 머신일 수 있다. 각 노드는 마스터에 의해 관리된다.
- 하나의 노드는 여러 개의 파드를 가질 수 있고, 쿠버네티스 마스터는 클러스터 내 노드를 통해서 파드에 대한 스케쥴링을 자동으로 처리한다.
- https://d33wubrfki0l68.cloudfront.net/5cb72d407cbe2755e581b6de757e0d81760d5b86/a9df9/docs/tutorials/kubernetes-basics/public/images/module_03_nodes.svg

-------------------------------------------------------------------------------
- 서비스가 필요한 이유?? -> 동일 노드 상의 파드들이라 할지라도, 쿠버네티스 클러스터 내 각 파드는 유일한 IP 주소를 가지며,
  여러분의 애플리케이션들이 지속적으로 기능할 수 있도록 파드들 속에서 발생하는 변화에 대해 자동으로 조정해 줄 방법이 있어야 한다.
- 서비스가 대상으로 하는 파드 셋은 보통 LabelSelector에 의해 결정된다.
- 비록 각 파드들이 고유의 IP를 갖고 있기는 하지만, 그 IP들은 서비스의 도움없이 클러스터 외부로 노출되어질 수 없다.
- 서비스들은 ServiceSpec에서 type을 지정함으로써 다양한 방식들로 노출시킬 수 있다
- LoadBalancer - 기존 클라우드에서 외부용 로드밸런서를 생성하고 서비스에 고정된 공인 IP를 할당해준다.
- https://d33wubrfki0l68.cloudfront.net/7a13fe12acc9ea0728460c482c67e0eb31ff5303/2c8a7/docs/tutorials/kubernetes-basics/public/images/module_04_labels.svg
- 서비스는 노출된 디플로이먼트의 모든 파드에 네트워크 트래픽을 분산시켜줄 통합된 로드밸런서를 갖는다.
- 서비스는 엔드포인트를 이용해서 구동중인 파드를 지속적으로 모니터링함으로써 가용한 파드에만 트래픽이 전달되도록 해준다.
- https://d33wubrfki0l68.cloudfront.net/043eb67914e9474e30a303553d5a4c6c7301f378/0d8f6/docs/tutorials/kubernetes-basics/public/images/module_05_scaling1.svg
- https://d33wubrfki0l68.cloudfront.net/30f75140a581110443397192d70a4cdb37df7bfc/b5f56/docs/tutorials/kubernetes-basics/public/images/module_05_scaling2.svg
-------------------------------------------------------------------------------
- 클러스터 전체적인 이미지(https://d33wubrfki0l68.cloudfront.net/2475489eaf20163ec0f54ddc1d92aa8d4c87c96b/e7c81/images/docs/components-of-kubernetes.svg)
-------------------------------------------------------------------------------
- 핵심 (또는 레거시 라고 불리는) 그룹은 REST 경로 /api/v1에 있다. 핵심 그룹은 apiVersion 필드의 일부로 명시되지 않는다.
  (예를 들어, apiVersion: v1)
- 이름이 있는 그룹은 REST 경로 /apis/$GROUP_NAME/$VERSION에 있으며 apiVersion: $GROUP_NAME/$VERSION을 사용한다.  
  (예를 들어, apiVersion: apps/v1)
- https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.21/#deployment-v1-apps

-------------------------------------------------------------------------------
- apiVersion: 오브젝트를 생성하기 위해 사용하고 있는 쿠버네티스API버전이 어떤것인지
- kind: 어떤 종류의 오브젝트를 생성하고자 하는지
- metadata: 이름 문자열(/api/v1/pods/some-name과 같이, 리소스 URL에서 오브젝트를 가리키는 클라이언트 제공 문자열.),
 UID(오브젝트를 중복 없이 식별하기 위해), 선택적인 네임스페이스를 포함하여 오브젝트를 유일하게 구분지어 줄 데이터(다른 오브젝트와 구별하기위해서 사용하는 듯)
- spec: 오브젝트에 대해 어떤 상태를 의도하는지(내가 원하는 상태)
  - selector: labels선택기, 템플릿의 labels와 일치해야한다.
  - strategy: The deployment strategy to use to replace existing pods with new ones.
  - template: pod에 대한 설명
metadata: {
    labels: {
        key1:value1,
        key2:value2
    }
}
- labels은 파드와 같은 오브젝트에 첨부된 키와 값의 쌍이다. 레이블은 오브젝트의 특성을 식별하는 데 사용
- 레이블을 사용하여 오브젝트를 선택하고, 특정 조건을 만족하는 오브젝트 컬렉션을 찾을 수 있다
-------------------------------------------------------------------------------
metadata:
  annotations:
    metallb.universe.tf/allow-shared-ip: shared
- annotations: 어노테이션을 이용하여 임의의 비-식별 메타데이터를 오브젝트에 첨부할 수 있다. 도구 및 라이브러리와 같은 클라이언트는 이 메타데이터를 검색할 수 있다.
- 어노테이션은 오브젝트를 식별하고 선택하는데 사용되지 않는다.

-------------------------------------------------------------------------------
containers:
    - image: mysql:latest
      imagePullPolicy: Never
- 컨테이너의 imagePullPolicy 값은 오브젝트가 처음 created 일 때 항상 설정되고 나중에 이미지 태그가 변경되더라도 업데이트되지 않는다.
- 예를 들어, 태그가 :latest가 아닌 이미지로 디플로이먼트를 생성하고, 나중에 해당 디플로이먼트의 이미지를 :latest 태그로 업데이트하면 imagePullPolicy 필드가 Always 로 변경되지 않는다. 오브젝트를 처음 생성 한 후 모든 오브젝트의 풀 정책을 수동으로 변경해야 한다.
- imagePullPolicy 가 특정값 없이 정의되면, Always 로 설정된다.
- 컨테이너의 imagePullPolicy 속성이 IfNotPresent 또는 Never으로 설정되어 있다면, 로컬 이미지가 사용된다
-------------------------------------------------------------------------------
spec:
    restartPolicy: Always
- 파드의 spec 에는 restartPolicy 필드가 있다. 사용 가능한 값은 Always, OnFailure 그리고 Never이다. 기본값은 Always이다.
- restartPolicy 는 파드의 모든 컨테이너에 적용된다.
- restartPolicy 는 동일한 노드에서 kubelet에 의한 컨테이너 재시작만을 의미한다. 
-------------------------------------------------------------------------------
livenessProbe:
    tcpSocket:
        port: 22
    initialDelaySeconds: 5
    periodSeconds: 3
- livenessProbe: 컨테이너가 동작 중인지 여부를 나타낸다. 만약 활성 프로브(liveness probe)에 실패한다면, kubelet은 컨테이너를 죽이고, 해당 컨테이너는 재시작 정책의 대상이 된다. 만약 컨테이너가 활성 프로브를 제공하지 않는 경우, 기본 상태는 Success이다.
- 프로브가 실패한 후 컨테이너가 종료되거나 재시작되길 원한다면, 활성 프로브를 지정하고, restartPolicy를 항상(Always) 또는 실패 시(OnFailure)로 지정한다.

-------------------------------------------------------------------------------
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   0/3     0            0           1s
- NAME: 디플로이먼트의 이름
- READY: 사용자가 사용할 수 있는 애플리케이션의 레플리카의 수를 표시한다. ready/desired 패턴을 따른다.
- UP-TO-DATE: 의도한 상태를 얻기 위해 업데이트된 레플리카의 수를 표시한다.
- AVAILABLE: 사용자가 사용할 수 있는 애플리케이션 레플리카의 수를 표시한다.
- AGE: 애플리케이션의 실행된 시간을 표시한다.
-------------------------------------------------------------------------------
metadata:
  annotations:
    metallb.universe.tf/allow-shared-ip: shared
- 내부 로드 밸런서를 설정하려면, 사용 중인 클라우드 서비스 공급자에 따라 어노테이션를 서비스에 추가한다.
-------------------------------------------------------------------------------
NAME       ENDPOINTS                     AGE
my-nginx   10.244.2.5:80,10.244.3.4:80   1m
- 클러스터의 모든 노드에서 <Cluster-IP>:<PORT>로 nginx서비스를 curl을 할 수 있을 것이다.
- 서비스 IP는 완전히 가상이므로 외부에서는 절대로 연결되지 않음에 참고한다
-------------------------------------------------------------------------------
* 볼륨
spec:
    template:
          spec:
            container: 
                volumeMounts:
                    - name: grafana-config
                      mountPath: /usr/share/grafana/conf/custom.ini
                      subPath: custom.ini
                    - name: provisioning
                      mountPath: /usr/share/grafana/conf/provisioning
            volumes:
                - name: grafana-config
                  configMap:
                    name: grafana-config
                    items:
                        - key: custom.ini
                          path: custom.ini
- 볼륨은 파드 내에서 실행되는 모든 컨테이너보다 오래 지속되며, 컨테이너를 다시 시작해도 데이터가 보존된다. 파드가 더 이상 존재하지 않으면, 쿠버네티스는 임시(ephemeral) 볼륨을 삭제하지만, 퍼시스턴트(persistent) 볼륨은 삭제하지 않는다.
- 볼륨을 사용하려면, .spec.volumes 에서 파드에 제공할 볼륨을 지정하고 .spec.containers[*].volumeMounts 의 컨테이너에 해당 볼륨을 마운트할 위치를 선언한다.
- 파드 구성의 각 컨테이너는 각 볼륨을 마운트할 위치를 독립적으로 지정해야 한다.
-------------------------------------------------------------------------------
* 컨피그맵(configMap)
- 컨피그맵은 구성 데이터를 파드에 주입하는 방법을 제공한다. 컨피그맵에 저장된 데이터는 configMap 유형의 볼륨에서 참조되고 그런 다음에 파드에서 실행되는 컨테이너화된 애플리케이션이 소비한다.
- 컨피그맵을 참조할 때, 볼륨에 컨피그맵의 이름을 제공한다. 컨피그맵의 특정 항목에 사용할 경로를 사용자 정의할 수 있다.
- 다음 구성은 log-config 컨피그맵을 configmap-pod 라 부르는 파드에 마운트하는 방법을 보여준다.
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
spec:
  containers:
    - name: test
      image: busybox
      volumeMounts:
        - name: config-vol
          mountPath: /etc/config
  volumes:
    - name: config-vol
      configMap:
        name: log-config
        items:
          - key: log_level
            path: log_level
- log-config 컨피그맵은 볼륨으로 마운트되며, log_level 항목에 저장된 모든 컨텐츠는 파드의 /etc/config/log_level 경로에 마운트된다.
- 이 경로는 볼륨의 mountPath 와 log_level 로 키가 지정된 path 에서 파생된다.
- 컨피그맵을 subPath 볼륨 마운트로 사용하는 컨테이너는 컨피그맵 업데이트를 수신하지 않는다.
-------------------------------------------------------------------------------
* persistentVolumeClaim
- persistentVolumeClaim 볼륨은 퍼시스턴트볼륨을 파드에 마운트하는데 사용한다.
- 퍼시스턴트볼륨클레임은 사용자가 특정 클라우드 환경의 세부 내용을 몰라도 내구성이있는 스토리지를 "클레임" 할 수 있는 방법이다.
-------------------------------------------------------------------------------
* subPath 사용하기
- 때로는 단일 파드에서 여러 용도의 한 볼륨을 공유하는 것이 유용하다. volumeMounts.subPath 속성을 사용해서 root 대신 참조하는 볼륨 내의 하위 경로를 지정할 수 있다.
- 다음의 예시는 단일 공유 볼륨을 사용하여 LAMP 스택(리눅스 Apache MySQL PHP)이 있는 파드를 구성하는 방법을 보여준다. 
- PHP 애플리케이션의 코드와 자산은 볼륨의 html 폴더에 매핑되고 MySQL 데이터베이스는 볼륨의 mysql 폴더에 저장된다.
apiVersion: v1
kind: Pod
metadata:
  name: my-lamp-site
spec:
    containers:
    - name: mysql
      image: mysql
      env:
      - name: MYSQL_ROOT_PASSWORD
        value: "rootpasswd"
      volumeMounts:
      - mountPath: /var/lib/mysql
        name: site-data
        subPath: mysql
    - name: php
      image: php:7.0-apache
      volumeMounts:
      - mountPath: /var/www/html
        name: site-data
        subPath: html
    volumes:
    - name: site-data
      persistentVolumeClaim:
        claimName: my-lamp-site-data
-------------------------------------------------------------------------------
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce //ReadWriteOnce -- 하나의 노드에서 볼륨을 읽기-쓰기로 마운트할 수 있다
  hostPath:
    path: "/mnt/data"
- 설정 파일에 클러스터 노드의 /mnt/data 에 볼륨이 있다고 지정한다. 
- 또한 설정에서 볼륨 크기를 10 기가바이트로 지정하고 단일 노드가 읽기-쓰기 모드로 볼륨을 마운트할 수 있는 ReadWriteOnce 접근 모드를 지정한다. 
- 여기서는 퍼시스턴트볼륨클레임의 스토리지클래스 이름을 manual 로 정의하며, 퍼시스턴트볼륨클레임의 요청을 이 퍼시스턴트볼륨에 바인딩하는데 사용한다.
- storageClassName이 없는 PV에는 클래스가 없으며 특정 클래스를 요청하지 않는 PVC에만 바인딩할 수 있다.
-------------------------------------------------------------------------------
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv
  labels:
    app: mysql
spec:
  accessModes:
    - ReadWriteOnce
  resources:  //리소스는 볼륨에 있어야하는 최소 리소스를 나타냅니다.
    requests: //요청은 필요한 최소 컴퓨팅 리소스 양을 설명합니다.
      storage: 1Gi

-------------------------------------------------------------------------------
     volumes:
      - name: mysql-pv
        persistentVolumeClaim:
          claimName: mysql-pv
- 설정 파일은 퍼시스턴트볼륨클레임을 지정하지만, 퍼시스턴트볼륨을 지정하지는 않는다는 것을 유념하자. 파드의 관점에서 볼때, 클레임은 볼륨이다.
-------------------------------------------------------------------------------
* 일반적인 구성 팁 
- JSON보다는 YAML을 사용해 구성 파일을 작성한다. 비록 이러한 포맷들은 대부분의 모든 상황에서 통용되어 사용될 수 있지만, YAML이 좀 더 사용자 친화적인 성향을 가진다.
- 의미상 맞다면 가능한 연관된 오브젝트들을 하나의 파일에 모아 놓는다. 때로는 여러 개의 파일보다 하나의 파일이 더 관리하기 쉽다. 이 문법의 예시로서 [https://github.com/kubernetes/examples/blob/master/guestbook/all-in-one/guestbook-all-in-one.yaml] 파일을 참고한다.
-------------------------------------------------------------------------------
* 컨피그맵(ConfigMap)
- 컨피그맵은 키-값 쌍으로 기밀이 아닌 데이터를 저장하는 데 사용하는 API 오브젝트이다. 
- 파드는 볼륨에서 환경 변수, 커맨드-라인 인수 또는 구성 파일로 컨피그맵을 사용할 수 있다.
-  컨피그맵은 보안 또는 암호화를 제공하지 않는다. 저장하려는 데이터가 기밀인 경우, 컨피그맵 대신 시크릿(Secret) 또는 추가(써드파티) 도구를 사용하여 데이터를 비공개로 유지하자.
- 컨피그맵은 다른 오브젝트가 사용할 구성을 저장할 수 있는 API 오브젝트이다.
- spec 이 있는 대부분의 쿠버네티스 오브젝트와 달리, 컨피그맵에는 data 및 binaryData 필드가 있다. 이러한 필드는 키-값 쌍을 값으로 허용한다.
-------------------------------------------------------------------------------
* 파드에서 컨피그맵을 파일로 사용하기
- 파드의 볼륨에서 컨피그맵을 사용하려면 다음을 수행한다.

1. 컨피그맵을 생성하거나 기존 컨피그맵을 사용한다. 여러 파드가 동일한 컨피그맵을 참조할 수 있다.
2. 파드 정의를 수정해서 .spec.volumes[] 아래에 볼륨을 추가한다. 볼륨 이름은 원하는 대로 정하고, 컨피그맵 오브젝트를 참조하도록 .spec.volumes[].configMap.name 필드를 설정한다.
3. 컨피그맵이 필요한 각 컨테이너에 .spec.containers[].volumeMounts[] 를 추가한다. .spec.containers[].volumeMounts[].readOnly = true 를 설정하고 컨피그맵이 연결되기를 원하는 곳에 사용하지 않은 디렉터리 이름으로 .spec.containers[].volumeMounts[].mountPath 를 지정한다.
4. 프로그램이 해당 디렉터리에서 파일을 찾도록 이미지 또는 커맨드 라인을 수정한다. 컨피그맵의 data 맵 각 키는 mountPath 아래의 파일 이름이 된다.

다음은 볼륨에 컨피그맵을 마운트하는 파드의 예시이다.

apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: mypod
    image: redis
    volumeMounts:
    - name: foo
      mountPath: "/etc/foo"
      readOnly: true
  volumes:
  - name: foo
    configmap:
      name: myconfigmap
- 사용하려는 각 컨피그맵은 .spec.volumes 에서 참조해야 한다.
- 파드에 여러 컨테이너가 있는 경우 각 컨테이너에는 자체 volumeMounts 블록이 필요하지만, 컨피그맵은 각 컨피그맵 당 하나의 .spec.volumes 만 필요하다.
-------------------------------------------------------------------------------
* 시크릿(Secret)
- 쿠버네티스 시크릿을 사용하면 비밀번호, OAuth 토큰, ssh 키와 같은 민감한 정보를 저장하고 관리할 수 ​​있다.
- 기밀 정보를 시크릿에 저장하는 것이 파드(Pod) 정의나 컨테이너 이미지 내에 그대로 두는 것보다 안전하고 유연하다.
- 사용자는 시크릿을 위한 파일을 구성할 때 data 및 (또는) stringData 필드를 명시할 수 있다. 해당 data 와 stringData 필드는 선택적으로 명시할 수 있다. 
-------------------------------------------------------------------------------
* 시크릿 타입
- 시크릿 타입은 시크릿 데이터의 프로그래믹 처리를 촉진시키기 위해 사용된다.
빌트인                                             타입	사용처
Opaque	                                      임의의 사용자 정의 데이터
kubernetes.io/service-account-token   	        서비스 어카운트 토큰
kubernetes.io/dockercfg	                직렬화 된(serialized) ~/.dockercfg 파일
kubernetes.io/dockerconfigjson        	직렬화 된 ~/.docker/config.json 파일
kubernetes.io/basic-auth	                기본 인증을 위한 자격 증명(credential)
kubernetes.io/ssh-auth	                        SSH를 위한 자격 증명
kubernetes.io/tls	                          TLS 클라이언트나 서버를 위한 데이터
bootstrap.kubernetes.io/token	                  부트스트랩 토큰 데이터
-------------------------------------------------------------------------------
* 불투명(Opaque) 시크릿
- Opaque 은 시크릿 구성 파일에서 누락된 경우의 기본 시크릿 타입이다. kubectl 을 사용하여 시크릿을 생성할 때 Opaque 시크릿 타입을 나타내기 위해서는 generic 하위 커맨드를 사용할 것이다. 예를 들어, 다음 커맨드는 타입 Opaque 의 비어 있는 시크릿을 생성한다.

kubectl create secret generic empty-secret
kubectl get secret empty-secret
출력은 다음과 같다.

NAME           TYPE     DATA   AGE
empty-secret   Opaque   0      2m6s
- 해당 DATA 열은 시크릿에 저장된 데이터 아이템의 수를 보여준다. 이 경우, 0 은 비어 있는 시크릿을 하나 생성하였다는 것을 의미한다.
-------------------------------------------------------------------------------
apiVersion: v1
kind: Secret
metadata:
  name: ssh-secret
stringData:
  username: user
  password: pass
특정 시나리오의 경우 stringData필드를 대신 사용할 수 있습니다 . 이 필드를 사용하면 base64로 인코딩되지 않은 문자열을 Secret에 직접 넣을 수 있으며 해당 문자열은 Secret이 생성되거나 업데이트 될 때 인코딩됩니다.
-------------------------------------------------------------------------------
* 시크릿을 환경 변수로 사용하기

1. 시크릿을 생성하거나 기존 시크릿을 사용한다. 여러 파드가 동일한 시크릿을 참조할 수 있다.
2. 사용하려는 각 시크릿 키에 대한 환경 변수를 추가하려면 시크릿 키 값을 사용하려는 각 컨테이너에서 파드 정의를 수정한다. 시크릿 키를 사용하는 환경 변수는 시크릿의 이름과 키를 env[].valueFrom.secretKeyRef 에 채워야 한다.
3. 프로그램이 지정된 환경 변수에서 값을 찾도록 이미지 및/또는 커맨드 라인을 수정한다.
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
spec:
  containers:
  - name: mycontainer
    image: redis
    env:
      - name: SECRET_USERNAME
        valueFrom:
          secretKeyRef:
            name: mysecret
            key: username
      - name: SECRET_PASSWORD
        valueFrom:
          secretKeyRef:
            name: mysecret
            key: password
  restartPolicy: Never
-------------------------------------------------------------------------------
Kubectl apply
apply는 쿠버네티스 리소스를 정의하는 파일을 통해 애플리케이션을 관리한다. kubectl apply를 실행하여 클러스터에 리소스를 생성하고 업데이트한다. 이것은 프로덕션 환경에서 쿠버네티스 애플리케이션을 관리할 때 권장된다. Kubectl Book을 참고한다.



-------------------------------------------------------------------------------
- 클러스터 구동 -> 디플로이먼트 설정 -> 컨트롤플레인이 디플로이먼트설정을 보고 노드의 파드안에 컨테이너 배포