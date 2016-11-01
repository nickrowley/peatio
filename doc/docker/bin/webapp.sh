# build Dockerfile to image zimbitx:base first !!!
docker run -d --name webapp \
  -p 80:80 -p 18080:18080 -p 443:443 \
  --link rabbitmq:rabbitmq \
  --link dbmaster:dbmaster \
  --link redis:redis \
  zimbitx:base /sbin/my_init --enable-insecure-key

docker-bash webapp bash -lc 'cd /home/app/zimbitx/; git pull;'
docker-bash webapp bash -lc 'cd /home/app/zimbitx/; RAILS_ENV=production ./bin/rake db:migrate;'
docker-bash webapp bash -lc 'cd /home/app/zimbitx/; RAILS_ENV=production ./bin/rake assets:precompile;'
