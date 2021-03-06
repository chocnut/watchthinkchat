class Campaign < ActiveRecord::Base
  SUBDOMAIN ||= /\A((?!app)[a-z0-9][a-z0-9\-]*[a-z0-9]|[a-z0-9])\z/
  CNAME ||= /\A^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?\z/
  # associations
  has_many :permissions, as: :resource, dependent: :destroy
  has_many :users, through: :permissions
  has_many :alternate_locales, dependent: :destroy
  has_many :locales, through: :alternate_locales
  belongs_to :locale
  has_one :engagement_player,
          dependent: :destroy,
          class_name: 'Campaign::EngagementPlayer',
          validate: true
  has_one :survey,
          dependent: :destroy,
          class_name: 'Campaign::Survey',
          validate: true
  has_one :community,
          dependent: :destroy,
          class_name: 'Campaign::Community',
          validate: true
  has_one :share,
          dependent: :destroy,
          class_name: 'Campaign::Share',
          validate: true
  has_one :growthspace,
          dependent: :destroy,
          class_name: 'Campaign::Growthspace',
          validate: true
  has_many :interactions,
           dependent: :destroy,
           class_name: 'Visitor::Interaction'
  accepts_nested_attributes_for :engagement_player, update_only: true
  accepts_nested_attributes_for :survey, update_only: true
  accepts_nested_attributes_for :community, update_only: true
  accepts_nested_attributes_for :share, update_only: true
  accepts_nested_attributes_for :growthspace, update_only: true

  # validations
  validates :url, uniqueness: true, allow_blank: true
  validates :name, presence: true, unless: :basic?
  validates :locale, presence: true, unless: :basic?
  validates :url, presence: true, unless: :basic?
  validates :url, length: { maximum: 63 }, if: :subdomain?
  validates :url, length: { maximum: 255 }, unless: :subdomain?
  validates :url,
            format: { with: SUBDOMAIN,
                      if: :subdomain? },
            allow_blank: true
  validates :url,
            format: { with: CNAME,
                      unless: :subdomain? },
            allow_blank: true
  # callbacks
  after_create do
    campaign.create_survey
  end

  # definitions
  enum status: [:basic,
                :closed,
                :opened,
                :engagement_player,
                :survey,
                :share,
                :community,
                :growthspace] unless instance_methods.include? :status
  translates :name, :intro, :description
  scope :owner, (lambda do
    where('permissions.state = ?', Permission.states[:owner].to_i)
  end)
  scope :translator, (lambda do
    where('permissions.state = ?', Permission.states[:translator].to_i)
  end)

  def campaign
    self
  end
end
