module PfiMruby
  class Command
    def initialize(argv:, use:, short:, long: nil, run: nil)
      @argv = argv
      @use = use
      @short = short
      @long = long || short
      @run = run
      @commands = []
    end

    def execute
      @run.call(self)
    end

    def generate_command_info
      info = @commands.map{ |cmd| { name: cmd.use, description: cmd.short } }
      info << { name: 'help', description: 'Help about any command' }
      info.sort{ |x,y| x[:name] <=> y[:name] } 
    end

    def help
      str = @long
      str << "\n"
      str << "Usage\n"
      str << "#{@use} [command]\n"
      str << "\n"
      str << "Available Commands:\n"
      generate_command_info.each do |cmd|
        str << "  #{cmd[:name]}     #{cmd[:description]}"
      end
      puts str
    end
  end
end
