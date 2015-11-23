module PuppetX
  module Puppetlabs
    module Swagger
      # We purposefully inherit from Exception here due to PUP-3656
      # If we throw something based on StandardError prior to Puppet 4
      # the exception will prevent the prefetch, but the provider will
      # continue to run with incorrect data.
      class PrefetchError < Exception
        def initialize(type, exception=nil)
          @type = type
          @exception = exception
        end

        def to_s
          """Puppet detected a problem with the information returned from the service when accessing #{@type}. The specific error was:
  #{@exception.message}

  #{@exception.backtrace.join("\n")}
  """
        end
      end
    end
  end
end
