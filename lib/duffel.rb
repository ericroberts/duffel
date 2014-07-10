class Duffel
  VERSION = "0.0.2"

  def self.method_missing(method, *args, &block)
    fetch_default = lambda do |key|
      raise KeyError.new("key not found: #{key}")
    end

    define_singleton_method(method) do |options=(args.first || {})|
      return_value = options.fetch(:fallback, fetch_default)
      fallback = return_value.is_a?(Proc) ? return_value : lambda { |key| return_value }

      env_name = method.to_s.upcase
      ENV.fetch(env_name, &fallback)
    end
    self.send(method)
  end
end
