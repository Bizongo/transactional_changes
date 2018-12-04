require "transactional_changes/version"

module TransactionalChanges
  extend ActiveSupport::Concern

  included do
    attr_reader :transaction_changes
    after_initialize :reset_previous_transaction_changes
    after_save :track_changes
    after_commit :reset_current_transaction_changes
  end

  def attribute_had_changed?(attr)
    @transaction_changes[attr.to_s].present?
  end

  def keys_changed
    @transaction_changes.keys
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /(\w+)_had_changed\?/ && self.attributes.keys.include?($1)
      attribute_had_changed?($1)
    else
      super
    end
  end

  private

  def track_changes
    @new_transaction_changes ||= HashWithIndifferentAccess.new

    self.changes.each do |key, value|
      #This is to track all the changes to a particular attribute in a transaction.
      if @new_transaction_changes[key].present?
        @new_transaction_changes[key] << value.second
      else
        @new_transaction_changes[key] = value
      end
    end
  end

  def reset_current_transaction_changes
    @transaction_changes = @new_transaction_changes
    @new_transaction_changes  = HashWithIndifferentAccess.new
  end

  def reset_previous_transaction_changes
    @transaction_changes = HashWithIndifferentAccess.new
  end
end
