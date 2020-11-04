RSpec.shared_examples :matches_comment_keyword do |keyword|
  it "returns comments that match #{keyword}" do
    job = create(:comment, description: "bla #{keyword} bla")
    expect(subject.call).to include(job)
  end
end

RSpec.shared_examples :does_not_match_comment_keyword do |keyword|
  it "does not return comments that match #{keyword}" do
    job = create(:comment, description: "bla #{keyword} bla")
    expect(subject.call).not_to include(job)
  end
end
