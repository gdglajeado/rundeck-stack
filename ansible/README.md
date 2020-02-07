```
docker run --rm \
-v $(pwd):/root \
-w /root \
raffaeldutra/docker-ansible-2.8:1.0 ansible-galaxy install -r requirements.yml
```

```
docker run --rm \
-v $(pwd):/root \
-w /root \
raffaeldutra/docker-ansible-2.8:1.0 ansible-playbook -i hosts site.yml
```