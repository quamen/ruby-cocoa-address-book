require 'osx/cocoa'
OSX.require_framework "AddressBook"

class Person

  def initialize(ab_person_or_hash = nil)
    if ab_person_or_hash.is_a?(OSX::ABPerson)
      @ab_record = ab_person_or_hash
    else
      @ab_record =  OSX::ABPerson.new
      @ab_record.removeValueForProperty("uniqueId") if ab_person_or_hash.nil?
    end

    if ab_person_or_hash.is_a?(HashWithIndifferentAccess)
      update_attributes(ab_person_or_hash)
    end
  end

  def new_record?
    true unless @ab_record.send(:valueForProperty, "uniqueId")
  end

  def to_param
    @ab_record.send(:valueForProperty, "uniqueId")
  end

  def self.find(person_id)
    if person_id == :all
      OSX::ABAddressBook.sharedAddressBook.people.collect { |person| Person.new(person)}
    else
      Person.new(OSX::ABAddressBook.sharedAddressBook.recordForUniqueId(person_id.to_s))
    end
  end

  def method_missing(method, *args)
    self.class_eval do
      define_method "#{method}" do
        @ab_record.send(:valueForProperty, method.to_s.capitalize)
      end
    end

    self.send("#{method}".to_sym)
  end
end