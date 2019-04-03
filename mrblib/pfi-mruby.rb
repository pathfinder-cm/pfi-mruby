def __main__(argv)
  if argv[1] == "version"
    puts "v#{PfiMruby::VERSION}"
  else
    puts "(P)ath(f)inder (I)nterface"
  end
end
