require "rails_helper"

RSpec.describe FeedbackMessage, type: :model do
  describe "validations for an abuse report" do
    subject(:feedback_message) do
      described_class.new(
        feedback_type: "abuse-reports",
        reported_url: "https://letsbuild.gg",
        category: "spam",
        message: "something",
      )
    end

    it { is_expected.to validate_presence_of(:feedback_type) }
    it { is_expected.to validate_presence_of(:reported_url) }
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_length_of(:reported_url).is_at_most(250) }
    it { is_expected.to validate_length_of(:message).is_at_most(2500) }

    it do
      expect(feedback_message).to validate_inclusion_of(:category).
        in_array(["spam", "other", "rude or vulgar", "harassment", "bug"])
    end
  end

  describe "validations for a bug report" do
    subject(:feedback_message) do
      described_class.new(
        feedback_type: "bug-reports",
        category: "bug",
        message: "something",
      )
    end

    it { is_expected.to validate_presence_of(:feedback_type) }
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.not_to validate_presence_of(:reported_url) }

    it do
      expect(feedback_message).to validate_inclusion_of(:category).
        in_array(["spam", "other", "rude or vulgar", "harassment", "bug"])
    end
  end
end
