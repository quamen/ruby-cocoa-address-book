# require 'osx/cocoa'
# OSX.require_framework "AddressBook"
# 
# module ABRecord
#   class Base
# 
#     def initialize(ab_record)
#       @ab_record = ab_record
#     end
#     
#     def new_record?
#       true unless @ab_record.send(:valueForProperty, "uniqueId")
#     end
#     
#     def to_param
#       @ab_record.send(:valueForProperty, "uniqueId")
#     end
#   
#     def method_missing(method, *args)
#       self.class_eval do
#         define_method "#{method}" do
#           @ab_record.send(:valueForProperty, method.to_s.capitalize)
#         end
#       end
#     
#       self.send("#{method}".to_sym)
#      end
#   end
# end
