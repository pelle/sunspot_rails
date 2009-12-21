require 'escape'

module Sunspot #:nodoc:
  module Rails #:nodoc:
    class Util
      class << self
        def sunspot_options
          @sunspot_options ||= {}
        end
        
        def index_relevant_attribute_changed?(object)
          klass = object.class
          class_keys = []
          while klass != ActiveRecord::Base do
            class_keys << klass.to_s.underscore.to_sym
            klass = klass.superclass
          end   
          class_sunspot_options = nil
          class_keys.each do |key|
            class_sunspot_options = sunspot_options[key]
            break unless class_sunspot_options.nil?
          end
          ignore_attributes = (class_sunspot_options[:ignore_attribute_changes_of] || [])
          !(object.changes.symbolize_keys.keys - ignore_attributes).blank?
        end
        
      end
    end
  end
end
