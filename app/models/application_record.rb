class ApplicationRecord < ActiveRecord::Base
  use_switch_point :common

  self.abstract_class = true
end
