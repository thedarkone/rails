module ActionController
  module UrlFor
    extend ActiveSupport::Concern

    include AbstractController::UrlFor

    def _script_name
      if defined?(@_script_name)
        @_script_name
      else
        @_script_name = _routes.equal?(env["action_dispatch.routes"]) && request.script_name.dup.presence
      end
    end

    def url_options
      options, script_name = super.dup, _script_name

      options[:script_name] = script_name if script_name

      options[:host]           ||= request.host_with_port
      options[:protocol]       ||= request.protocol
      options[:_path_segments] ||= request.symbolized_path_parameters

      options
    end
  end
end
