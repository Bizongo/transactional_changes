require "active_record"
require "pry"
require "spec_helper_models"
require "transactional_changes"

class Dummy < ActiveRecord::Base
  include TransactionalChanges
end

RSpec.describe TransactionalChanges do
  let(:dummy) { Dummy.new }

  it "has a version number" do
    expect(TransactionalChanges::VERSION).not_to be nil
  end

  it "track keys that has been changed after_commit" do
    dummy.save!
    dummy.keys_changed.each do |attribute|
      expect(Dummy.new.attributes.keys).to include(attribute)
    end
  end

  it "returns false if any attribute had not changed" do
    dummy = Dummy.last
    expect(dummy.name_had_changed?).to eq(false)
    expect(dummy.slug_had_changed?).to eq(false)
  end

  it "returns true if any attribute had changed" do
    dummy = Dummy.last
    ActiveRecord::Base.transaction do
      dummy.name = "deadpool"
      dummy.save
      dummy.slug = "abc"
      dummy.save
    end
    expect(dummy.name_had_changed?).to eq(true)
    expect(dummy.slug_had_changed?).to eq(true)
  end
end
