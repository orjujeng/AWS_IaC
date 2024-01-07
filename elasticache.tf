#cmd of ec2 connect redis
# sudo yum install gcc -y
# sudo wget http://download.redis.io/redis-stable.tar.gz
# sudo tar -xzvf redis-stable.tar.gz
# cd redis-stable
# sudo make
# sudo cp src/redis-cli /usr/bin
# redis-cli -h host no port num -p port -a password

resource "aws_elasticache_subnet_group" "orjujeng_redis_subnet_group" {
  name        = "orjujeng-redis-subnet-group"
  description = "This subnet group is only cover the private subnet of a1 and c1 zone"
  subnet_ids  = [aws_subnet.orjujeng_private_net_1a.id, aws_subnet.orjujeng_private_net_1c.id]
}
# one instance of redis
# resource "aws_elasticache_cluster" "orjujeng_elasticache_replica" {
#   cluster_id           = "orjujeng-elasticache"
#   engine               = "redis"
#   node_type            = "cache.t3.micro"
#   num_cache_nodes      = 1
#   parameter_group_name = "default.redis7"
#   engine_version       = "7.1"
#   port                 = 6379
#   security_group_ids   = [aws_security_group.orjujeng_redis_sg.id]
#   subnet_group_name    = aws_elasticache_subnet_group.orjujeng_redis_subnet_group.name
#   tags = {
#     name = "orjujeng_elasticache_replica"
#   }
# }

resource "aws_elasticache_parameter_group" "default_redis7_cluster_on_springsession" {
  name   = "orjujeng-redis7-parameter-group"
  family = "redis7"
  parameter {
    name  = "notify-keyspace-events"
    value = "Egx"
  }
  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }
}

#cluster and booster mode
resource "aws_elasticache_replication_group" "orjujeng_elasticache_cluster" {
  automatic_failover_enabled = true
  replication_group_id       = "orjujeng-elasticache-cluster"
  description                = "orjujeng_elasticache_cluster"
  node_type                  = "cache.t3.micro"
  num_cache_clusters         = 1
  parameter_group_name       = aws_elasticache_parameter_group.default_redis7_cluster_on_springsession.name
  engine_version             = "7.1"
  engine                     = "redis"
  port                       = 6379
  #num_node_groups            = 1 conflict with num_cache_clusters num_node_groups = number of Shards only first shards with w/r 
  #replicas_per_node_group    = 2 number of node in shards
  multi_az_enabled   = false
  subnet_group_name  = aws_elasticache_subnet_group.orjujeng_redis_subnet_group.name
  security_group_ids = [aws_security_group.orjujeng_redis_sg.id]
  tags = {
    name = "orjujeng_elasticache_cluster"
  }
}

#cmd of ec2 connect redis
# sudo yum install gcc -y
# sudo wget http://download.redis.io/redis-stable.tar.gz
# sudo tar -xzvf redis-stable.tar.gz
# cd redis-stable
# sudo make
# sudo cp src/redis-cli /usr/bin
# redis-cli -h host orjujeng-elasticache-cluster.4ublli.clustercfg.apne1.cache.amazonaws.com -p port -a password

#https://stackoverflow.com/questions/55231851/unable-to-access-redis-cluster-mode-enabled-clusters-endpoints