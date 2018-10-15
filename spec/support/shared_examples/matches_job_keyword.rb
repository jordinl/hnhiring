RSpec.shared_examples :matches_job_keyword do |keyword|
  it "returns jobs that match #{keyword}" do
    job = create(:job, description: "bla #{keyword} bla")
    expect(subject.call).to include(job)
  end
end

RSpec.shared_examples :does_not_match_job_keyword do |keyword|
  it "does not return jobs that match #{keyword}" do
    job = create(:job, description: "bla #{keyword} bla")
    expect(subject.call).not_to include(job)
  end
end
