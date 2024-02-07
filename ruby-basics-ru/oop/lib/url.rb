# frozen_string_literal: true

class Url
  def initialize(attribute)
    @attribute = attribute
  end

  def host
    @attribute.split('://').last.split('?').first.split(':').first
  end

  def except_params
    @attribute.split('?').first
  end

  def scheme
    @attribute.split('://').first
  end

  def query_params
    return {} unless @attribute.include?('?')

    query = @attribute.split('?').last
    query.split('&').map { |pair| pair.split('=') }.to_h.transform_keys {|key| key.to_sym }
  end

  def query_param(key, default = nil)
    query_params[key.to_s.to_sym] || default
  end

  def ==(other)
    self.except_params == other.except_params ? to_s <=> other.to_s : to_s == other.to_s
  end

  def to_s
    @attribute
  end

  def inspect
    to_s
  end
end
