require "spec_helper"

RSpec.describe Gggiiifff::Query, type: :model do
  describe "#present?" do
    context "when there is a query" do
      subject { Gggiiifff::Query.new(q: "funny cats") }

      it "returns true" do
        expect(subject.present?).to be_truthy
      end
    end

    context "when there is not query" do
      subject { Gggiiifff::Query.new(q: " ") }

      it "returns false" do
        expect(subject.present?).to be_falsey
      end
    end
  end
end
