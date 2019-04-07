def __main__(argv)
  PATHFINDER_SCHEME = 'http'
  PATHFINDER_ADDRESS = 'localhost'
  PATHFINDER_PORT = 3000
  CLUSTER_NAME = 'default'
  AUTHENTICATION_TOKEN = 'pathfinder'

  pathfinder = Pathfinder::PathfinderExt.new(
    cluster_name: CLUSTER_NAME,
    authentication_token: AUTHENTICATION_TOKEN,
    scheme: PATHFINDER_SCHEME,
    address: PATHFINDER_ADDRESS,
    port: PATHFINDER_PORT
  )

  root_command = PfiMruby::Command.new(
    use: 'pfi',
    short: 'pfi is CLI for Pathfinder Container Manager',
    long: "(P)ath(f)inder (I)nterface
                CLI for Pathfinder Container Manager.
                See http://github.com/pathfinder-cm/pfi"
  )

  get_command = PfiMruby::Command.new(
    use: 'get',
    short: 'Specify things to get',
    long: 'Specify things to get'
  )
  root_command.add_command(get_command)

  get_nodes_command = PfiMruby::Command.new(
    use: 'nodes',
    short: 'List all available nodes',
    long: 'List all available nodes',
    run: Proc.new { |command, argv|
      _, nodes = pathfinder.get_nodes
      puts "Hostname, Ipaddress"
      nodes.each do |node|
        puts "#{node.hostname}, #{node.ipaddress}"
      end
    }
  )
  get_command.add_command(get_nodes_command)

  get_containers_command = PfiMruby::Command.new(
    use: 'containers',
    short: 'List all available containers',
    long: 'List all available containers',
    run: Proc.new { |command, argv|
      _, containers = pathfinder.get_containers
      puts "Hostname, Ipaddress, Image, Status"
      containers.each do |container|
        puts "#{container.hostname}, #{container.ipaddress}, #{container.image}, #{container.status}"
      end
    }
  )
  get_command.add_command(get_containers_command)

  create_command = PfiMruby::Command.new(
    use: 'create',
    short: 'Specify things to create',
    long: 'Specify things to create'
  )
  root_command.add_command(create_command)

  create_container_command = PfiMruby::Command.new(
    use: 'container',
    short: 'Create a container',
    long: 'Create a container',
    run: Proc.new { |command, argv|
      _, container = pathfinder.create_container(
        container: Pathfinder::Container.new(hostname: argv[1], image: argv[2])
      )
      puts "Container '#{argv[1]}' created!"
    }
  )
  create_command.add_command(create_container_command)

  delete_command = PfiMruby::Command.new(
    use: 'delete',
    short: 'Specify things to delete',
    long: 'Specify things to delete'
  )
  root_command.add_command(delete_command)

  delete_container_command = PfiMruby::Command.new(
    use: 'container',
    short: 'Delete a container',
    long: 'Delete a container',
    run: Proc.new { |command, argv|
      _, container = pathfinder.delete_container(
        container: Pathfinder::Container.new(hostname: argv[1])
      )
      puts "Container '#{argv[1]}' deleted!"
    }
  )
  delete_command.add_command(delete_container_command)

  reschedule_command = PfiMruby::Command.new(
    use: 'reschedule',
    short: 'Specify things to reschedule',
    long: 'Specify things to reschedule'
  )
  root_command.add_command(reschedule_command)

  reschedule_container_command = PfiMruby::Command.new(
    use: 'container',
    short: 'Reschedule a container',
    long: 'Reschedule a container',
    run: Proc.new { |command, argv|
      _, container = pathfinder.reschedule_container(
        container: Pathfinder::Container.new(hostname: argv[1])
      )
      puts "Container '#{argv[1]}' rescheduled!"
    }
  )
  reschedule_command.add_command(reschedule_container_command)

  version_command = PfiMruby::Command.new(
    use: 'version',
    short: 'Show pfi version',
    long: 'Show pfi version',
    run: Proc.new { |command, argv| puts "v#{PfiMruby::VERSION}" }
  )
  root_command.add_command(version_command)

  root_command.execute(argv)
end
