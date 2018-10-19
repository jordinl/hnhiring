require 'rails_helper'

RSpec.describe Keyword do
  describe 'finders' do
    describe 'react' do
      subject { Keyword::DEFINITIONS[:react] }

      it_behaves_like :matches_job_keyword, 'react'
      it_behaves_like :matches_job_keyword, 'react.js'
      it_behaves_like :matches_job_keyword, 'reactjs'
      it_behaves_like :matches_job_keyword, 'react, react-native'
      it_behaves_like :does_not_match_job_keyword, 'reaction'
      it_behaves_like :does_not_match_job_keyword, 'react-native'
      it_behaves_like :does_not_match_job_keyword, 'react native'
    end

    describe 'C' do
      subject { Keyword::DEFINITIONS[:c] }

      it_behaves_like :matches_job_keyword, 'C,'
      it_behaves_like :matches_job_keyword, 'C.'
      it_behaves_like :matches_job_keyword, 'C/C++'
      it_behaves_like :matches_job_keyword, 'C, C++'
      it_behaves_like :matches_job_keyword, 'C, C#'
      it_behaves_like :matches_job_keyword, 'C, Objective-C'
      it_behaves_like :does_not_match_job_keyword, 'c'
      it_behaves_like :does_not_match_job_keyword, 'C.S'
      it_behaves_like :does_not_match_job_keyword, 'Clojure'
      it_behaves_like :does_not_match_job_keyword, 'C++'
      it_behaves_like :does_not_match_job_keyword, 'C#'
      it_behaves_like :does_not_match_job_keyword, 'Objective-C,'
      it_behaves_like :does_not_match_job_keyword, 'objective-C,'
      it_behaves_like :does_not_match_job_keyword, 'Objective C,'
      it_behaves_like :does_not_match_job_keyword, 'objective C,'
      it_behaves_like :does_not_match_job_keyword, 'objective C,'
      it_behaves_like :does_not_match_job_keyword, 'obj C,'
      it_behaves_like :does_not_match_job_keyword, 'obj-C,'
    end
  end
end
