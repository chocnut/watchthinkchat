class Locale < ActiveRecord::Base
  # associations
  has_many :alternate_locales,
           dependent: :destroy,
           class_name: 'Campaign::AlternateLocale'
  has_many :locales, through: :alternate_locales

  # validations
  validates :code, presence: true
  validates :name, presence: true
end
