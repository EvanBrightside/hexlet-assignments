# frozen_string_literal: true

require 'date'

module Model
  def initialize *attributes
    attributes = attributes.first || {}
    self.class.attributes.each do |name, options|
      value = attributes[name] || options[:default]
      value = convert_value(options[:type], value)
      instance_variable_set("@#{name}", value)
    end
  end

  def self.attribute (name, type:, default: nil)
    @attributes ||= {}
    @attributes[name] = { type: type, default: default }
  end

  def self.attributes
    @attributes
  end

  def self.included(base) # base is the class that includes the module
    base.extend ClassMethods
  end

  module ClassMethods
    def attribute (name, type:, default: nil) 
      @attributes ||= {}
      @attributes[name] = { type: type, default: default }

      # Getter
      define_method "#{name}" do
        self.instance_variable_get "@#{name}"
      end
      # Setter
      define_method "#{name}=" do |value|
        value = convert_value(type, value)
        self.instance_variable_set "@#{name}", value
      end
    end

    def attributes
      @attributes
    end
  end

  def attributes
    self.class.attributes.keys.each_with_object({}) do |name, result|
      result[name] = send(name)
    end
  end

  private
  
  def convert_value(type, value)
    return value if value.nil?

    case type
    when :integer then value.to_i
    when :string then value.to_s
    when :datetime then DateTime.parse(value)
    when :boolean then value
    end
  end
end
