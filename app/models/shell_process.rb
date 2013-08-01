require 'open3'
class ShellProcess
  def initialize(*args)
    @args = args
  end

  def success?
    guard_run
    @status.success?
  end

  def output
    guard_run
    @output
  end

  def status
    guard_run
    @status
  end

  private
  def guard_run
    has_run? || run
  end

  def has_run?
    @status || false
  end

  def run
    return if has_run?

    @output = ''

    IO.popen @args, 'r', err: %i{child out} do |stdout|
      @output << stdout.read
    end

    @status = $?
  end
end