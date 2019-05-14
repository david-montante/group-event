class GroupEvent < ActiveRecord::Base
    scope :active, -> { where(deleted: false) }
end
