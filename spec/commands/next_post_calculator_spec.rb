require 'rails_helper'

RSpec.describe NextPostCalculator do
  context "When 1st day of the month is a weekday" do
    before { Timecop.freeze(Time.zone.local(2020, 11, 28)) }

    it "returns 1st day of the month at 5PM ET" do
      expect(subject.call).to eq(Time.zone.local(2020, 12, 1, 11))
    end
  end

  context "When 1st day of the month is a Saturday" do
    before { Timecop.freeze(Time.zone.local(2020, 7, 30)) }

    it "returns following Monday at 5PM" do
      expect(subject.call).to eq(Time.zone.local(2020, 8, 3, 11))
    end
  end

  context "When 1st day of the month is a Sunday" do
    before { Timecop.freeze(Time.zone.local(2020, 10, 28)) }

    it "returns following Monday at 5PM" do
      expect(subject.call).to eq(Time.zone.local(2020, 11, 2, 11))
    end
  end

  context "When post should be published today and it's before 5PM ET" do
    before { Timecop.freeze(Time.zone.local(2020, 11, 2, 11, 0)) }

    it "returns today's date" do
      expect(subject.call).to eq(Time.zone.local(2020, 11, 2, 11))
    end
  end

  context "When post should be published today and it's after 5PM ET" do
    before { Timecop.freeze(Time.zone.local(2020, 11, 2, 11, 0, 1)) }

    it "returns next month's date" do
      expect(subject.call).to eq(Time.zone.local(2020, 12, 1, 11))
    end
  end
end
