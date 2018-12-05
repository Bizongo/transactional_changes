# TransactionalChanges

This gem provides all the changes that has been made in a transaction.
FYR, `ActiveModel::Dirty` provides a method `previous_changes` which only shows the last change that has been made. "https://api.rubyonrails.org/classes/ActiveModel/Dirty.html"

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'transactional_changes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transactional_changes

## Usage

dummy = Dummy.new
dummy.name_had_changed? # => false

dummy.name = "Vikash"
dummy.save!
dummy.name_had_changed? # => true

ActiveRecord::Base.transaction do
  dummy.name = "Vikash Singh"
  dummy.save!
  dummy.slug = "bla bla"
  dummy.save!
end

dummy.transaction_changes
{"name"=>["Vikash", "Vikash Singh"], "slug"=>[nil, "bla bla"], "updated_at"=>[Wed, 05 Dec 2018 12:34:04 IST +05:30, Wed, 05 Dec 2018 12:54:31 IST +05:30, Wed, 05 Dec 2018 12:54:31 IST +05:30]}
