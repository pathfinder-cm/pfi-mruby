def __main__(argv)
  PATHFINDER_PORT = 3000
  CLUSTER_NAME = 'default'
  AUTHENTICATION_TOKEN = 'pathfinder'

  root_command = PfiMruby::Command.new(
    use: 'pfi',
    short: 'pfi is CLI for Pathfinder Container Manager',
    long: "(P)ath(f)inder (I)nterface
                CLI for Pathfinder Container Manager.
                See http://github.com/pathfinder-cm/pfi",
    run: Proc.new { |command, argv| command.help }
  )

  get_command = PfiMruby::Command.new(
    use: 'get',
    short: 'Specify things to get',
    long: 'Specify things to get',
    run: Proc.new { |command, argv| command.help }
  )

  get_nodes_command = PfiMruby::Command.new(
    use: 'nodes',
    short: 'List all available nodes',
    long: 'List all available nodes',
    run: Proc.new { |command, argv|
      pathfinder = Pathfinder::PathfinderExt.new(port: PATHFINDER_PORT)
      _, nodes = pathfinder.get_nodes(cluster_name: CLUSTER_NAME, authentication_token: AUTHENTICATION_TOKEN)
      puts "Hostname, Ipaddress"
      nodes.each do |node|
        puts "#{node.hostname}, #{node.ipaddress}"
      end
    }
  )

  get_containers_command = PfiMruby::Command.new(
    use: 'containers',
    short: 'List all available containers',
    long: 'List all available containers',
    run: Proc.new { |command, argv|
      pathfinder = Pathfinder::PathfinderExt.new(port: PATHFINDER_PORT)
      _, containers = pathfinder.get_containers(cluster_name: CLUSTER_NAME, authentication_token: AUTHENTICATION_TOKEN)
      puts "Hostname, Ipaddress, Image, Status"
      containers.each do |container|
        puts "#{container.hostname}, #{container.ipaddress}, #{container.image}, #{container.status}"
      end
    }
  )

  version_command = PfiMruby::Command.new(
    use: 'version',
    short: 'Show pfi version',
    long: 'Show pfi version',
    run: Proc.new { |command, argv| puts "v#{PfiMruby::VERSION}" }
  )

  get_command.add_command(get_nodes_command)
  get_command.add_command(get_containers_command)
  root_command.add_command(get_command)
  root_command.add_command(version_command)
  root_command.execute(argv)
end
