class Duffel
  VERSION = "0.0.2"

  class << self

    def method_missing(method, *args, &block)
      define_singleton_method(method) do |options={}|
        options ||= {}
        return_value = options.fetch(:fallback, fetch_default)
        fallback = format_return_value(return_value)

        env_name = method.to_s.upcase
        ENV.fetch(env_name, &fallback)
      end
      self.send(method, args.first)
    end

  protected

    def format_return_value(value)
      if value.is_a?(Proc)
        value
      else
        lambda { |_key| value }
      end
    end

    def fetch_default
      lambda do |key|
        raise KeyError.new("key not found: #{key}")
      end
    end
  end
end
