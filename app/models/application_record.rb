
# This file defines the ApplicationRecord class, which serves as the base class
# for all models in the Rails application. It inherits from ActiveRecord::Base and
# provides common functionality and configuration for all models.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
