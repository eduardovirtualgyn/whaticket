#######################################
# creates REDIS db using docker
# Arguments:
#   None
#######################################
backend_redis_create() {
  print_banner
  printf "${WHITE} 💻 Criando Redis & Banco Postgres...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  # Adiciona o usuário ao grupo Docker (se ainda não estiver)
  usermod -aG docker deployautomatizaai

  # Cria o contêiner Redis
  docker run --name redis-redis -p 6379:6379 --restart always --detach redis redis-server --requirepass ${db_pass}
EOF

  sleep 2
}