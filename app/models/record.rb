class Record < ActiveRecord::Base
  belongs_to :membership

  enum code: [:enter, :leave]
end
