require 'rails_helper'

RSpec.describe Keyword do
  describe 'finders' do
    describe 'react' do
      subject { Keyword::FINDERS.dig(:technology, :react) }

      it_behaves_like :matches_comment_keyword, 'react'
      it_behaves_like :matches_comment_keyword, 'react.js'
      it_behaves_like :matches_comment_keyword, 'reactjs'
      it_behaves_like :matches_comment_keyword, 'react, react-native'
      it_behaves_like :does_not_match_comment_keyword, 'reaction'
      it_behaves_like :does_not_match_comment_keyword, 'react-native'
      it_behaves_like :does_not_match_comment_keyword, 'react native'
    end

    describe 'C' do
      subject { Keyword::FINDERS.dig(:technology, :c) }

      it_behaves_like :matches_comment_keyword, 'C,'
      it_behaves_like :matches_comment_keyword, 'C.'
      it_behaves_like :matches_comment_keyword, 'C/C++'
      it_behaves_like :matches_comment_keyword, 'C, C++'
      it_behaves_like :matches_comment_keyword, 'C, C#'
      it_behaves_like :matches_comment_keyword, 'C, Objective-C'
      it_behaves_like :does_not_match_comment_keyword, 'c'
      it_behaves_like :does_not_match_comment_keyword, 'C.S'
      it_behaves_like :does_not_match_comment_keyword, 'Clojure'
      it_behaves_like :does_not_match_comment_keyword, 'C++'
      it_behaves_like :does_not_match_comment_keyword, 'C#'
      it_behaves_like :does_not_match_comment_keyword, 'Objective-C,'
      it_behaves_like :does_not_match_comment_keyword, 'objective-C,'
      it_behaves_like :does_not_match_comment_keyword, 'Objective C,'
      it_behaves_like :does_not_match_comment_keyword, 'objective C,'
      it_behaves_like :does_not_match_comment_keyword, 'objective C,'
      it_behaves_like :does_not_match_comment_keyword, 'obj C,'
      it_behaves_like :does_not_match_comment_keyword, 'obj-C,'
    end
  end
end
