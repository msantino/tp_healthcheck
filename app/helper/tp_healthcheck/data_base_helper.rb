# frozen_string_literal: true

module TPHealthcheck::DataBaseHelper
  def database_on?
    return true if Gem.loaded_specs['activerecord'].nil?
    ActiveRecord::Base.connection.active?
  end
end
