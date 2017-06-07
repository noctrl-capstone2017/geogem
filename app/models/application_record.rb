# Application Record
# Author: Meagan Moore

# abstract model means you can inherit from it without using STI
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
