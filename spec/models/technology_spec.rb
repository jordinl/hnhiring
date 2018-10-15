require 'rails_helper'

RSpec.describe Technology do
  describe 'finders' do
    describe 'react' do
      subject { Technology::DEFINITIONS[:react] }

      it_behaves_like :matches_job_keyword, 'react'
      it_behaves_like :matches_job_keyword, 'react.js'
      it_behaves_like :matches_job_keyword, 'reactjs'
      it_behaves_like :matches_job_keyword, 'react, react-native'
      it_behaves_like :does_not_match_job_keyword, 'reaction'
      it_behaves_like :does_not_match_job_keyword, 'react-native'
      it_behaves_like :does_not_match_job_keyword, 'react native'
    end
  end
end
