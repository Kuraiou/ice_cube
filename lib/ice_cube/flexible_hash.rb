require "delegate"

module IceCube
  # Find keys by symbol or string without symbolizing user input
  # Due to the serialization format of ice_cube, this limited implementation
  # is entirely sufficient

  class FlexibleHash < SimpleDelegator
    def [](key)
      key = _match_key(key)
      super
    end

    def fetch(key)
      key = _match_key(key)
      super
    end

    def delete(key)
      key = _match_key(key)
      super
    end

    private

    def _match_key(key)
      obj = __getobj__
      return key if obj.has_key? key

      case key
      when Symbol
        string_key = key.to_s
        obj.keys.find { |k| k == string_key }
      when String 
        sym_key = key.to_sym
        obj.keys.find { |k| k == sym_key }
      else
        key
      end
    end
  end
end
