module CliMacros
  def run_command(command)
    run_simple(
      "bundle exec #{command}"
    )
  end

  def command_output
    all_commands.map(&:output).join("\n")
  end
end
