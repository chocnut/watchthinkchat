require 'rails_helper'

RSpec.describe Campaign::Share, type: :model do
  it { is_expected.to belong_to :campaign }
  it { is_expected.to validate_presence_of :campaign }
  it { is_expected.to have_db_column(:subject).of_type(:string) }
  it { is_expected.to have_db_column(:message).of_type(:text) }
  it { is_expected.to have_db_column(:facebook).of_type(:boolean).with_options(default: true) }
  it { is_expected.to have_db_column(:twitter).of_type(:boolean).with_options(default: true) }
  it { is_expected.to have_db_column(:email).of_type(:boolean).with_options(default: true) }
  it { is_expected.to have_db_column(:link).of_type(:boolean).with_options(default: true) }
end
