
remote_file '/opt/kafka_2.11-2.0.0.tgz' do
  source 'http://www-us.apache.org/dist/kafka/2.0.0/kafka_2.11-2.0.0.tgz'
  owner 'root'
  group 'root'
  mode '0744'
  action :create
  notifies :run, 'execute[kafka_unzip]', :immediately
end

execute 'kafka_unzip' do
  command 'tar -xzf /opt/kafka_2.11-2.0.0.tgz -C /opt'
end

bash 'kafka_start' do
  user 'root'
  cwd '/opt/kafka_2.11-2.0.0'
  code <<-EOH
  nohup bin/zookeeper-server-start.sh config/zookeeper.properties &
  sleep 10
  nohup bin/kafka-server-start.sh config/server.properties &
  EOH
 end


