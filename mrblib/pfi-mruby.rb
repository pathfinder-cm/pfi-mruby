def __main__(argv)
  command = PfiMruby::Command.new(
    argv: argv,
    use: 'pfi',
    short: 'pfi is CLI for Pathfinder Container Manager',
    long: "(P)ath(f)inder (I)nterface
                CLI for Pathfinder Container Manager.
                See http://github.com/pathfinder-cm/pfi",
    run: Proc.new { |command| command.help }
  )
  command.execute
end
